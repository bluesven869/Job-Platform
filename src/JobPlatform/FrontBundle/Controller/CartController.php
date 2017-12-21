<?php

namespace JobPlatform\FrontBundle\Controller;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;

class CartController extends Controller
{
    /**
     * @Route("/cart", name="cart_list")
     */
    public function listAction(Request $request, $page = 1)
    {
        $products = $request->getSession()->get('products');
        $new_products = [];

        $total = 0;
        if ($products) {
            foreach ($products as $product) {
                if ($product['job_id']) {
                    $product['job'] = $this->getDoctrine()->getRepository('AppBundle:Job')->findOneBy(
                        ['id' => $product['job_id']]
                    );
                    $new_products[] = $product;

                    $payments = $this->getParameter('app.payments');
                    $total += $payments[$product['type']]['price'];
                }
            }
        }

        return $this->render(
            'FrontBundle::Cart/list.html.twig',
            [
                'products' => $new_products,
                'total' => $total,
                'breadcrumbs' => [
                    [
                        'link' => $this->get('router')->generate('homepage'),
                        'title' => $this->get('translator')->trans('Home'),
                    ],
                    ['title' => $this->get('translator')->trans('Shopping Cart')],
                ],
            ]
        );
    }

    /**
     * @Route("/cart/delete/{type}/{job_id}", name="cart_delete", requirements={"type": "\w+", "job_id": "\d+"})
     */
    public function deleteAction(Request $request, $type, $job_id)
    {
        $products = $request->getSession()->get('products');

        if ($products) {
            $new_products = [];
            foreach ($products as $product) {
                if ($product['job_id'] == $job_id && $product['type'] == $type) {
                    $this->addFlash(
                        'success',
                        $this->get('translator')->trans('Product has been successfully removed from cart.')
                    );
                } else {
                    $new_products[] = $product;
                }
            }

            $request->getSession()->set('products', $new_products);
        } else {
            $this->addFlash('danger', $this->get('translator')->trans('Cart is already empty.'));
        }

        return $this->redirect($request->server->get('HTTP_REFERER'));
    }

    /**
     * @Route("/cart/empty", name="cart_empty")
     */
    public function emptyAction(Request $request)
    {
        $request->getSession()->remove('products');
        $this->addFlash('success', $this->get('translator')->trans('Cart has been successfully emptied.'));

        return $this->redirectToRoute('cart_list');
    }
}
