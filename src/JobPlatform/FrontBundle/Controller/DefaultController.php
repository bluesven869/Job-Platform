<?php

namespace JobPlatform\FrontBundle\Controller;

use JobPlatform\FrontBundle\Form\Type\FilterJobHeroType;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;

class DefaultController extends Controller
{
    /**
     * @Route("/", name="homepage")
     */
    public function indexAction(Request $request)
    {
        $jobRepository = $this->getDoctrine()->getRepository('AppBundle:Job');
        $categoryRepository = $this->getDoctrine()->getRepository('AppBundle:Category');

        $filter = $this->createForm(
            FilterJobHeroType::class,
            [],
            [
                'router' => $this->get('router'),
            ]
        );

        return $this->render(
            'FrontBundle::Front/index.html.twig',
            [
                'filter' => $filter->createView(),
                'jobs' => $jobRepository->findRecent(9),
                'categories' => $categoryRepository->findAll(),
            ]
        );
    }
}
