<?php

namespace JobPlatform\FrontBundle\Controller;

use JobPlatform\AppBundle\Entity\Order;
use JobPlatform\AppBundle\Entity\OrderItem;
use JobPlatform\AppBundle\Entity\Payment;
use JobPlatform\FrontBundle\Form\Type\OrderType;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\ParamConverter;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;

use Payum\Core\Request\GetHumanStatus;

class OrderController extends Controller
{
    /**
     * @Route("/accounts/orders", name="orders")
     */
    public function ordersAction(Request $request)
    {
        $orders = $this->getDoctrine()->getRepository('AppBundle:Order')->findAllByUser($this->getUser());
        $orders = $this->get('knp_paginator')->paginate($orders, $request->query->getInt('page', 1), 10);

        return $this->render(
            'FrontBundle::Orders/orders.html.twig',
            [
                'orders' => $orders,
            ]
        );
    }

    /**
     * @Route("/accounts/invoice/{id}", name="invoice", requirements={"id": "\d+"})
     * @ParamConverter("order", class="JobPlatform\AppBundle\Entity\Order")
     */
    public function invoiceAction(Request $request, Order $order)
    {
        if ($order->getStatus() != Order::STATUS_COMPLETED) {
            throw $this->createAccessDeniedException('You are not allowed to access this page.');
        }

        return $this->render(
            'FrontBundle::Orders/invoice.html.twig',
            [
                'order' => $order,
                'orderRepository' => $this->getDoctrine()->getRepository('AppBundle:Order'),
                'breadcrumbs' => [
                    [
                        'link' => $this->get('router')->generate('homepage'),
                        'title' => $this->get('translator')->trans('Home'),
                    ],
                    [
                        'link' => $this->get('router')->generate('orders'),
                        'title' => $this->get('translator')->trans('Orders'),
                    ],
                    [
                        'title' => $this->get('translator')->trans('Invoice'),
                    ],
                ],
            ]
        );
    }

    /**
     * @Route("/accounts/order/paypal/completed", name="order_paypal_completed")
     */
    public function orderPaypalCompletedAction(Request $request)
    {
        $token = $this->get('payum')->getHttpRequestVerifier()->verify($request);

        $identity = $token->getDetails();
        $payment = $this->get('payum')->getStorage($identity->getClass())->find($identity);

        $gateway = $this->get('payum')->getGateway($token->getGatewayName());
        $gateway->execute($status = new GetHumanStatus($payment));

        $order = $payment->getOrder();

        if ($status->isCaptured() || $status->isAuthorized()) {
            $order->setStatus(Order::STATUS_COMPLETED);
            $this->addFlash('success', $this->get('translator')->trans('Payment has been successful.'));
        }

        if ($status->isPending()) {
            $this->addFlash('danger', $this->get('translator')->trans('Payment has been canceled.'));
        }

        if ($status->isFailed() || $status->isCanceled()) {
            $order->setStatus(Order::STATUS_CANCELED);
            $this->addFlash('danger', $this->get('translator')->trans('Payment has been canceled.'));
        }

        try {
            $em = $this->getDoctrine()->getManager();
            $em->persist($order);
            $em->flush();
        } catch (\Exception $e) {
            $this->addFlash('danger', $this->get('translator')->trans('An error occurred when saving object.'));
        }


        return $this->redirectToRoute('orders');
    }

    /**
     * @Route("/accounts/checkout", name="checkout")
     */
    public function checkoutAction(Request $request)
    {
        $orderForm = $this->createForm(
            OrderType::class,
            null,
            [
                'user' => $this->getUser(),
                'gateways' => $this->getParameter('app.gateways'),
            ]
        );
        $orderForm->handleRequest($request);

        // Calculate total price
        $products = $request->getSession()->get('products');
        if (!$products) {
            $this->addFlash('danger', $this->get('translator')->trans('Cart is empty. Not able to proceed checkout.'));

            return $this->redirectToRoute('cart_list');
        }

        $price = 0;
        foreach ($products as $product) {
            $price += $product['price'];
        }

        // Save order
        if ($orderForm->isSubmitted() && $orderForm->isValid()) {
            $order = $orderForm->getData();
            $order->setStatus(Order::STATUS_NEW);
            $order->setUser($this->getUser());
            $order->setCurrency($this->getParameter('app.currency'));
            $order->setPrice($price);

            try {
                $em = $this->getDoctrine()->getManager();
                $em->persist($order);
                $em->flush();
            } catch (\Exception $e) {
                $this->addFlash('danger', $this->get('translator')->trans('An error occurred whe saving order.'));
            }


            // Save order items
            foreach ($products as $product) {
                $job = $this->getDoctrine()->getRepository('AppBundle:Job')->findOneBy(['id' => $product['job_id']]);

                $orderItem = new OrderItem();
                $orderItem->setOrder($order);
                $orderItem->setPrice($product['price']);
                $orderItem->setType($product['type']);
                $orderItem->setJob($job);
                $orderItem->setDuration($product['duration']);

                try {
                    $em = $this->getDoctrine()->getManager();
                    $em->persist($orderItem);
                    $em->flush();
                } catch (\Exception $e) {
                    $this->addFlash(
                        'danger',
                        $this->get('translator')->trans('An error occurred whe saving order item.')
                    );
                }
            }

            $request->getSession()->remove('products');
            $this->addFlash('success', $this->get('translator')->trans('Order has been successfully saved.'));

            if ($order->getGateway() == 'paypal') {
                $gatewayName = 'paypal_express_checkout';

                $storage = $this->get('payum')->getStorage(Payment::class);

                $payment = $storage->create();
                $payment->setNumber(uniqid());
                $payment->setCurrencyCode($this->getParameter('app.currency'));
                $payment->setTotalAmount($price * 100);
                $payment->setDescription('A description');
                $payment->setClientId($order->getCompany()->getId());
                $payment->setClientEmail($order->getCompany()->getEmail());
                $payment->setOrder($order);

                $storage->update($payment);

                $captureToken = $this->get('payum')->getTokenFactory()->createCaptureToken(
                    $gatewayName,
                    $payment,
                    'order_paypal_completed'
                );

                return $this->redirect($captureToken->getTargetUrl());
            }

            return $this->redirectToRoute('orders');
        }

        return $this->render(
            'FrontBundle::Orders/checkout.html.twig',
            [
                'order' => $orderForm->createView(),
                'breadcrumbs' => [
                    [
                        'link' => $this->get('router')->generate('homepage'),
                        'title' => $this->get('translator')->trans('Home'),
                    ],
                    [
                        'link' => $this->get('router')->generate('cart_list'),
                        'title' => $this->get('translator')->trans('Shopping Cart'),
                    ],
                    ['title' => $this->get('translator')->trans('Checkout')],
                ],
            ]
        );
    }
}
