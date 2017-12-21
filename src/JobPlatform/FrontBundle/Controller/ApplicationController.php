<?php

namespace JobPlatform\FrontBundle\Controller;

use JobPlatform\AppBundle\Entity\Application;
use JobPlatform\AppBundle\Entity\Job;
use JobPlatform\FrontBundle\Form\Type\ApplicationType;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\ParamConverter;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;

class ApplicationController extends Controller
{
    /**
     * @Route("/account/applicants", name="application_applicants")
     */
    public function applicantsAction(Request $request)
    {
        $applicants = $this->getDoctrine()->getRepository('AppBundle:Application')->findUserApplicants(
            $this->getUser()
        );
        $applicants = $this->get('knp_paginator')->paginate($applicants, $request->query->getInt('page', 1), 10);

        return $this->render(
            'FrontBundle::Applications/applicants.html.twig',
            [
                'applicants' => $applicants,
                'breadcrumbs' => [
                    [
                        'link' => $this->get('router')->generate('homepage'),
                        'title' => $this->get('translator')->trans('Home'),
                    ],
                    [
                        'title' => $this->get('translator')->trans('Applicants'),
                    ],
                ],
            ]
        );
    }

    /**
     * @Route("/account/proposals", name="application_proposals")
     */
    public function proposalsAction(Request $request)
    {
        $applications = $this->getDoctrine()->getRepository('AppBundle:Application')->findBy(
            ['user' => $this->getUser()]
        );
        $applications = $this->get('knp_paginator')->paginate($applications, $request->query->getInt('page', 1), 10);

        return $this->render(
            'FrontBundle::Applications/proposals.html.twig',
            [
                'applications' => $applications,
                'breadcrumbs' => [
                    [
                        'link' => $this->get('router')->generate('homepage'),
                        'title' => $this->get('translator')->trans('Home'),
                    ],
                    [
                        'title' => $this->get('translator')->trans('Proposals'),
                    ],
                ],
            ]
        );
    }

    /**
     * @Route("/accounts/proposals/create/{id}", name="application_create", requirements={"id": "\d+"})
     * @ParamConverter("job", class="JobPlatform\AppBundle\Entity\Job")
     */
    public function createAction(Request $request, Job $job)
    {
        // Job exists
        if (!$job) {
            $this->addFlash('danger', $this->get('translator')->trans('Job does not exists.'));

            return $this->redirect($request->server->get('HTTP_REFERER'));
        }

        // User is logged in
        if (!$this->getUser()) {
            $this->addFlash('danger', $this->get('translator')->trans('Please log in before submitting proposal.'));

            return $this->redirectToRoute('job_show', ['id' => $job->getId()]);
        }

        $form = $this->createForm(ApplicationType::class);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $application = $form->getData();
            $application->setUser($this->getUser());
            $application->setJob($job);

            try {
                $em = $this->getDoctrine()->getManager();
                $em->persist($application);
                $em->flush();
                $this->addFlash('success', $this->get('translator')->trans('Proposal has been successfully saved.'));
            } catch(\Exception $e) {
                $this->addFlash('danger', $this->get('translator')->trans('An error occurred when saving object.'));
            }

            return $this->redirectToRoute('job_show', ['id' => $job->getId()]);
        }

        return $this->render(
            'FrontBundle::Applications/create.html.twig',
            [
                'form' => $form->createView(),
            ]
        );
    }

    /**
     * @Route("/account/proposals/withdraw/{id}", name="application_withdraw", requirements={"id": "\d+"})
     * @ParamConverter("job", class="JobPlatform\AppBundle\Entity\Job")
     */
    public function withdrawAction(Request $request, Job $job)
    {
        if ($job->getUser() != $this->getUser()) {
            throw $this->createAccessDeniedException('You are not allowed to access this page.');
        }

        // Job exists
        if (!$job) {
            $this->addFlash('danger', $this->get('translator')->trans('Job does not exists.'));

            return $this->redirect($request->server->get('HTTP_REFERER'));
        }

        // User is logged in
        if (!$this->getUser()) {
            $this->addFlash('danger', $this->get('translator')->trans('Please log in before withdrawing application.'));

            return $this->redirect($request->server->get('HTTP_REFERER'));
        }

        $application = $this->getDoctrine()->getRepository('AppBundle:Application')->findOneBy(
            [
                'user' => $this->getUser(),
                'job' => $job,
            ]
        );

        if (!$application) {
            $this->addFlash('danger', $this->get('translator')->trans('You did not applied for this job.'));

            return $this->redirect($request->server->get('HTTP_REFERER'));
        }

        try {
            $em = $this->getDoctrine()->getManager();
            $em->remove($application);
            $em->flush();
            $this->addFlash('success', $this->get('translator')->trans('Application has been successfully withdrawn.'));
        } catch(\Exception $e) {
            $this->addFlash('danger', $this->get('translator')->trans('An error occurred when saving object'));
        }

        return $this->redirect($request->server->get('HTTP_REFERER'));
    }
}
