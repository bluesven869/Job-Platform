<?php

namespace JobPlatform\FrontBundle\Controller;

use JobPlatform\AppBundle\Entity\Favorite;
use JobPlatform\AppBundle\Entity\Job;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\ParamConverter;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;

class FavoriteController extends Controller
{
    /**
     * @Route("/account/favorites", name="favorite_list")
     */
    public function listAction(Request $request)
    {
        $favorites = $this->getDoctrine()->getRepository('AppBundle:Favorite')->findAllForUser($this->getUser());
        $favorites = $this->get('knp_paginator')->paginate($favorites, $request->query->getInt('page', 1), 10);

        return $this->render(
            'FrontBundle::Favorites/list.html.twig',
            [
                'favorites' => $favorites,
                'breadcrumbs' => [
                    [
                        'link' => $this->get('router')->generate('homepage'),
                        'title' => $this->get('translator')->trans('Home'),
                    ],
                    ['title' => $this->get('translator')->trans('Favorites')],
                ],
            ]
        );
    }

    /**
     * @Route("/account/favorites/add/{id}", name="favorite_add", requirements={"id": "\d+"})
     * @ParamConverter("job", class="JobPlatform\AppBundle\Entity\Job")
     */
    public function addAction(Request $request, Job $job)
    {
        // User authenticated
        if (!$this->getUser()) {
            $this->addFlash(
                'error',
                $this->get('translator')->trans('Please log in before adding job to favorite list.')
            );

            return $this->redirect($request->server->get('HTTP_REFERER'));
        }

        // Job exists
        if (!$job) {
            $this->addFlash('error', $this->get('translator')->trans('Job does not exists.'));

            return $this->redirect($request->server->get('HTTP_REFERER'));
        }

        // Favorite exists
        $favorite = $this->getDoctrine()->getRepository('AppBundle:Favorite')->findOneBy(
            [
                'user' => $this->getUser()->getId(),
                'job' => $job->getId(),
            ]
        );

        if ($favorite) {
            $this->addFlash('error', $this->get('translator')->trans('Job is already added in your favorite list.'));

            return $this->redirect($request->server->get('HTTP_REFERER'));
        }

        $favorite = new Favorite();
        $favorite->setUser($this->getUser());
        $favorite->setJob($job);

        try {
            $em = $this->getDoctrine()->getManager();
            $em->persist($favorite);
            $em->flush();

            $this->addFlash(
                'success',
                $this->get('translator')->trans('Job has been successfully added to your favorites.')
            );
        } catch (\Exception $e) {
            $this->addFlash('danger', $this->get('translator')->trans('An error occurred when saving object.'));
        }

        return $this->redirect($request->server->get('HTTP_REFERER'));
    }

    /**
     * @Route("/account/favorites/delete/{id}", name="favorite_remove", requirements={"id": "\d+"})
     * @ParamConverter("job", class="JobPlatform\AppBundle\Entity\Job")
     */
    public function deleteAction(Request $request, Job $job)
    {
        // User authenticated
        if (!$this->getUser()) {
            $this->addFlash(
                'error',
                $this->get('translator')->trans('Please log in before adding job to favorite list.')
            );

            return $this->redirect($request->server->get('HTTP_REFERER'));
        }

        // Job exists
        if (!$job) {
            $this->addFlash('error', $this->get('translator')->trans('Job does not exists.'));

            return $this->redirect($request->server->get('HTTP_REFERER'));
        }

        // Favorite exists
        $favorite = $this->getDoctrine()->getRepository('AppBundle:Favorite')->findOneBy(
            [
                'user' => $this->getUser()->getId(),
                'job' => $job->getId(),
            ]
        );

        if ($favorite->getUser() != $this->getUser()) {
            throw $this->createAccessDeniedException('You are not allowed to access this page.');
        }

        if (!$favorite) {
            $this->addFlash('error', $this->get('translator')->trans('Job is not in your favorite list.'));

            return $this->redirect($request->server->get('HTTP_REFERER'));
        }

        try {
            $em = $this->getDoctrine()->getManager();
            $em->remove($favorite);
            $em->flush();

            $this->addFlash(
                'success',
                $this->get('translator')->trans('Job has been successfully removed from your favorites.')
            );
        } catch (\Exception $e) {
            $this->addFlash(
                'danger',
                $this->get('translator')->trans('An error occurred when saving object.')
            );
        }


        return $this->redirect($request->server->get('HTTP_REFERER'));
    }
}
