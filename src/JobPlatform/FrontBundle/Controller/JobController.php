<?php

namespace JobPlatform\FrontBundle\Controller;

use JobPlatform\AppBundle\Entity\Application;
use JobPlatform\AppBundle\Entity\Job;
use JobPlatform\FrontBundle\Form\Type\FilterJobKeywordType;
use JobPlatform\FrontBundle\Form\Type\FilterJobType;
use JobPlatform\FrontBundle\Form\Type\JobType;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\ParamConverter;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;

class JobController extends Controller
{
    /**
     * @Route("/jobs", name="job_list")
     */
    public function listAction(Request $request)
    {
        $filter = $this->createForm(FilterJobType::class, [], ['router' => $this->get('router')]);
        $filter->handleRequest($request);

        $filterKeyword = $this->createForm(FilterJobKeywordType::class, [], ['router' => $this->get('router')]);
        $filterKeyword->handleRequest($request);

        $jobs = $this->getDoctrine()->getRepository('AppBundle:Job')->findByFilterQuery($request);
        $jobs = $this->get('knp_paginator')->paginate($jobs, $request->query->getInt('page', 1), 10);

        return $this->render(
            'FrontBundle::Jobs/list.html.twig',
            [
                'filter' => $filter->createView(),
                'filterKeyword' => $filterKeyword->createView(),
                'jobs' => $jobs,
                'breadcrumbs' => [
                    [
                        'link' => $this->get('router')->generate('homepage'),
                        'title' => $this->get('translator')->trans('Home'),
                    ],
                    [
                        'title' => $this->get('translator')->trans('Jobs'),
                    ],
                ],
            ]
        );
    }

    /**
     * @Route("/job/{id}", name="job_show", requirements={"id": "\d+"})
     * @ParamConverter("job", class="JobPlatform\AppBundle\Entity\Job")
     */
    public function showAction(Request $request, Job $job)
    {
        $hasUserJob = $this->getDoctrine()->getRepository('AppBundle:Job')->hasUserJob($this->getUser(), $job);
        if (!$job->getIsPublished() && !$hasUserJob) {
            throw $this->createAccessDeniedException('You are not allowed to access this page.');
        }

        $application = $this->getDoctrine()->getRepository('AppBundle:Application')->findOneBy(
            [
                'user' => $this->getUser(),
                'job' => $job,
            ]
        );

        return $this->render(
            'FrontBundle::Jobs/show.html.twig',
            [
                'hasCurrentUserApplied' => $application,
                'job' => $job,
                'breadcrumbs' => [
                    [
                        'link' => $this->get('router')->generate('homepage'),
                        'title' => $this->get('translator')->trans('Home'),
                    ],
                    [
                        'link' => $this->get('router')->generate('job_list'),
                        'title' => $this->get('translator')->trans('Jobs'),
                    ],
                    ['title' => $job->getName()],
                ],
            ]
        );
    }

    /**
     * @Route("/account/jobs", name="job_my")
     */
    public function myAction(Request $request)
    {
        $jobs = $this->getDoctrine()->getRepository('AppBundle:Job')->findUserJobs($this->getUser());
        $jobs = $this->get('knp_paginator')->paginate($jobs, $request->query->getInt('page', 1), 10);

        return $this->render(
            'FrontBundle::Jobs/my.html.twig',
            [
                'jobs' => $jobs,
                'breadcrumbs' => [
                    [
                        'link' => $this->get('router')->generate('homepage'),
                        'title' => $this->get('translator')->trans('Home'),
                    ],
                    ['title' => $this->get('translator')->trans('My Jobs')],
                ],
            ]
        );
    }

    /**
     * @Route("/account/jobs/create", name="job_create")
     */
    public function createAction(Request $request)
    {
        $job = new Job();

        $form = $this->createForm(
            JobType::class,
            $job,
            [
                'user' => $this->getUser(),
            ]
        );

        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $job = $form->getData();
            $job->setUser($this->getUser());

            try {
                $em = $this->getDoctrine()->getManager();
                $em->persist($job);
                $em->flush();
                $this->addFlash('success', $this->get('translator')->trans('Job has been successfully created.'));
            } catch (\Exception $e) {
                $this->addFlash('danger', $this->get('translator')->trans('An error occurred when saving object.'));
            }

            return $this->redirectToRoute('job_my');
        }

        return $this->render(
            'FrontBundle::Jobs/create.html.twig',
            [
                'form' => $form->createView(),
                'breadcrumbs' => [
                    [
                        'link' => $this->get('router')->generate('homepage'),
                        'title' => $this->get('translator')->trans('Home'),
                    ],
                    [
                        'link' => $this->get('router')->generate('job_my'),
                        'title' => $this->get('translator')->trans('My Jobs'),
                    ],
                    ['title' => $this->get('translator')->trans('Create')],
                ],
            ]
        );
    }

    /**
     * @Route("/account/jobs/update/{id}", name="job_update", requirements={"id": "\d+"})
     * @ParamConverter("job", class="JobPlatform\AppBundle\Entity\Job")
     */
    public function updateAction(Request $request, Job $job)
    {
        $form = $this->createForm(
            JobType::class,
            $job,
            [
                'user' => $this->getUser(),
            ]
        );

        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $job = $form->getData();

            try {
                $em = $this->getDoctrine()->getManager();
                $em->persist($job);
                $em->flush();
                $this->addFlash('success', $this->get('translator')->trans('Job has been successfully updated.'));
            } catch (\Exception $e) {
                $this->addFlash('danger', $this->get('translator')->trans('An error occurred when saving object.'));
            }


            return $this->redirectToRoute('job_my');
        }

        return $this->render(
            'FrontBundle::Jobs/update.html.twig',
            [
                'form' => $form->createView(),
                'breadcrumbs' => [
                    [
                        'link' => $this->get('router')->generate('homepage'),
                        'title' => $this->get('translator')->trans('Home'),
                    ],
                    [
                        'link' => $this->get('router')->generate('job_my'),
                        'title' => $this->get('translator')->trans('My Jobs'),
                    ],
                    ['title' => $job->getName()],
                ],
            ]
        );
    }

    /**
     * @Route("/account/jobs/delete/{id}", name="job_delete", requirements={"id": "\d+"})
     * @ParamConverter("job", class="JobPlatform\AppBundle\Entity\Job")
     */
    public function deleteAction(Request $request, Job $job)
    {

        if (!$this->getDoctrine()->getRepository('AppBundle:Job')->hasUserJob($this->getUser(), $job)) {
            throw $this->createAccessDeniedException('You are not allowed to access this page.');
        }

        try {
            $em = $this->getDoctrine()->getManager();
            $em->remove($job);
            $em->flush();
            $this->addFlash('success', $this->get('translator')->trans('Job has been successfully deleted.'));
        } catch (\Exception $e) {
            $this->addFlash('danger', $this->get('translator')->trans('An error occurred when deleting object.'));
        }

        return $this->redirectToRoute('job_my');
    }

    /**
     * @Route("/account/jobs/publish/{id}", name="job_publish", requirements={"id": "\d+"})
     * @ParamConverter("job", class="JobPlatform\AppBundle\Entity\Job")
     */
    public function publishAction(Request $request, Job $job)
    {
        $payments = $this->getParameter('app.payments');

        if ($payments['pay_for_publish']['enabled']) {
            $session = $request->getSession();


            if ($session->get('products')) {
                foreach ($session->get('products') as $product) {
                    if ($product['type'] == 'pay_for_publish' && $product['job_id'] == $job->getId()) {
                        $this->addFlash('danger', $this->get('translator')->trans('Product is already in cart.'));

                        return $this->redirectToRoute('job_my');
                    }
                }
            }

            $product = [
                'type' => 'pay_for_publish',
                'job_id' => $job->getId(),
                'price' => $payments['pay_for_publish']['price'],
                'duration' => $payments['pay_for_publish']['duration'],
            ];

            if ($session->has('products')) {
                $products = $session->get('products');

                array_push($products, $product);
                $session->set('products', $products);
            } else {
                $session->set('products', [$product]);
            }

            $this->addFlash(
                'success',
                $this->get('translator')->trans('Request for publishing job has been added into cart.')
            );
        } else {
            $job->setIsPublished(true);

            try {
                $em = $this->getDoctrine()->getManager();
                $em->persist($job);
                $em->flush();
            } catch (\Exception $e) {
                $this->addFlash('danger', $this->get('translator')->trans('An error occurred when saving object.'));
            }
        }

        return $this->redirectToRoute('job_my');
    }

    /**
     * @Route("/account/jobs/unpublish/{id}", name="job_unpublish", requirements={"id": "\d+"})
     * @ParamConverter("job", class="JobPlatform\AppBundle\Entity\Job")
     */
    public function unpublishAction(Request $request, Job $job)
    {
        $job->setIsPublished(false);

        try {
            $em = $this->getDoctrine()->getManager();
            $em->persist($job);
            $em->flush();
            $this->addFlash('success', $this->get('translator')->trans('Job has been successfully unpublished.'));
        } catch (\Exception $e) {
            $this->addFlash('danger', $this->get('translator')->trans('An error occurred when saving object.'));
        }

        return $this->redirectToRoute('job_my');
    }

    /**
     * @Route("/account/jobs/feature/{id}", name="job_feature", requirements={"id": "\d+"})
     * @ParamConverter("job", class="JobPlatform\AppBundle\Entity\Job")
     */
    public function featureAction(Request $request, Job $job)
    {
        $payments = $this->getParameter('app.payments');

        if ($payments['pay_for_featured']['enabled']) {
            $session = $request->getSession();

            if ($session->get('products')) {
                foreach ($session->get('products') as $product) {
                    if ($product['type'] == 'pay_for_featured' && $product['job_id'] == $job->getId()) {
                        $this->addFlash('danger', $this->get('translator')->trans('Product is already in cart.'));

                        return $this->redirectToRoute('job_my');
                    }
                }
            }

            $product = [
                'type' => 'pay_for_featured',
                'job_id' => $job->getId(),
                'price' => $payments['pay_for_featured']['price'],
                'duration' => $payments['pay_for_featured']['duration'],
            ];

            if ($session->has('products')) {
                $products = $session->get('products');

                array_push($products, $product);
                $session->set('products', $products);
            } else {
                $session->set('products', [$product]);
            }

            $this->addFlash(
                'success',
                $this->get('translator')->trans('Request for featuring job has been added into cart.')
            );
        } else {
            $job->setIsFeatured(true);

            try {
                $em = $this->getDoctrine()->getManager();
                $em->persist($job);
                $em->flush();

                $this->addFlash(
                    'success',
                    $this->get('translator')->trans('Job has been successfully marked as featured.')
                );
            } catch (\Exception $e) {
                $this->addFlash('danger', $this->get('translator')->trans('An error occurred when saving object.'));
            }
        }

        return $this->redirectToRoute('job_my');
    }

    /**
     * @Route("/account/jobs/unfeature/{id}", name="job_unfeature", requirements={"id": "\d+"})
     * @ParamConverter("job", class="JobPlatform\AppBundle\Entity\Job")
     */
    public function unfeatureAction(Request $request, Job $job)
    {
        $job->setIsFeatured(false);

        try {
            $em = $this->getDoctrine()->getManager();
            $em->persist($job);
            $em->flush();
            $this->addFlash(
                'success',
                $this->get('translator')->trans('Featured sign has been successfully removed from job.')
            );
        } catch (\Exception $e) {
            $this->addFlash('danger', $this->get('translator')->trans('An error occurred when saving object.'));
        }


        return $this->redirectToRoute('job_my');
    }
}
