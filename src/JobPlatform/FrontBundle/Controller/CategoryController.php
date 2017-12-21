<?php

namespace JobPlatform\FrontBundle\Controller;

use JobPlatform\AppBundle\Entity\Category;
use JobPlatform\FrontBundle\Form\Type\FilterJobKeywordType;
use JobPlatform\FrontBundle\Form\Type\FilterJobType;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\ParamConverter;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;

class CategoryController extends Controller
{
    /**
     * @Route("/category/{slug}/", name="category_list")
     * @ParamConverter("category", class="JobPlatform\AppBundle\Entity\Category")
     */
    public function listAction(Request $request, Category $category)
    {
        $request->query->set('categories', [$category->getId()]);

        $filterKeyword = $this->createForm(FilterJobKeywordType::class, [], ['router' => $this->get('router')]);
        $filterKeyword->handleRequest($request);

        $filter = $this->createForm(FilterJobType::class, [], ['router' => $this->get('router')]);
        $filter->handleRequest($request);

        $jobs = $this->getDoctrine()->getRepository('AppBundle:Job')->findByCategorySlug($category->getSlug());
        $jobs = $this->get('knp_paginator')->paginate($jobs, $request->query->getInt('page', 1), 10);

        return $this->render('FrontBundle::Jobs/list.html.twig', [
            'filterKeyword' => $filterKeyword->createView(),
            'filter' => $filter->createView(),
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
        ]);
    }
}
