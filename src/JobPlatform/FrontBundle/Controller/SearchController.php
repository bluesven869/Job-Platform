<?php

namespace JobPlatform\FrontBundle\Controller;

use JobPlatform\AppBundle\Entity\Search;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\ParamConverter;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;

class SearchController extends Controller
{
    /**
     * @Route("/account/searches", name="search_my")
     */
    public function myAction(Request $request)
    {
        $searches = $this->getDoctrine()->getRepository('AppBundle:Search')->findBy(['user' => $this->getUser()]);
        $searches = $this->get('knp_paginator')->paginate($searches, $request->query->getInt('page', 1), 10);

        return $this->render(
            'FrontBundle::Searches/my.html.twig',
            [
                'searches' => $searches,
                'breadcrumbs' => [
                    [
                        'link' => $this->get('router')->generate('homepage'),
                        'title' => $this->get('translator')->trans('Home'),
                    ],
                    ['title' => $this->get('translator')->trans('Searches')],
                ],
            ]
        );
    }

    /**
     * @Route("/account/searches/create/{entity}", name="search_create", requirements={"entity": "\w+"})
     */
    public function createAction(Request $request, $entity)
    {
        if (!empty($request->server->get('HTTP_REFERER'))) {
            $referer = $request->server->get('HTTP_REFERER');
            $query = '';
            list($base, $search) = explode('?', $referer);

            foreach (explode('&', $search) as $item) {
                list($key, $value) = explode('=', $item);

                if (!empty($value)) {
                    if (empty($query)) {
                        $query .= sprintf('%s=%s', urldecode($key), urldecode($value));
                    } else {
                        $query .= sprintf('&%s=%s', urldecode($key), urldecode($value));
                    }
                }
            }

            if (empty($query)) {
                $this->addFlash('success', $this->get('translator')->trans('Nothing to save.'));

                return $this->redirect($request->server->get('HTTP_REFERER'));
            }

            $search = new Search();
            $search->setUser($this->getUser());
            $search->setEntity($entity);
            $search->setQuery($query);

            try {
                $em = $this->getDoctrine()->getManager();
                $em->persist($search);
                $em->flush();
                $this->addFlash(
                    'success',
                    $this->get('translator')->trans('Search query has been successfully saved.')
                );
            } catch (\Exception $e) {
                $this->addFlash('danger', $this->get('translator')->trans('An error occurred when saving object.'));
            }

        }

        return $this->redirect($request->server->get('HTTP_REFERER'));
    }

    /**
     * @Route("/account/searches/delete/{id}", name="search_delete", requirements={"id": "\d+"})
     * @ParamConverter("search", class="JobPlatform\AppBundle\Entity\Search")
     */
    public function deleteAction(Request $request, Search $search)
    {
        if ($search->getUser() != $this->getUser()) {
            throw $this->createAccessDeniedException('You are not allowed to access this page.');
        }

        try {
            $em = $this->getDoctrine()->getManager();
            $em->remove($search);
            $em->flush();
            $this->addFlash('success', $this->get('translator')->trans('Search query has been successfully deleted.'));
        } catch (\Exception $e) {
            $this->addFlash('success', $this->get('translator')->trans('An error occurred when deleting object.'));
        }

        return $this->redirectToRoute('search_my');
    }
}
