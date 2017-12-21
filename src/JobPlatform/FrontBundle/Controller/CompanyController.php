<?php

namespace JobPlatform\FrontBundle\Controller;

use JobPlatform\FrontBundle\Form\Type\ContactType;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\ParamConverter;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use JobPlatform\FrontBundle\Form\Type\CompanyType;
use JobPlatform\FrontBundle\Form\Type\FilterCompanyType;
use JobPlatform\AppBundle\Entity\Company;

class CompanyController extends Controller
{
    /**
     * @Route("/companies", name="company_list")
     */
    public function listAction(Request $request)
    {
        $filter = $this->createForm(FilterCompanyType::class, [], ['router' => $this->get('router')]);
        $filter->handleRequest($request);

        $companies = $this->getDoctrine()->getRepository('AppBundle:Company')->findByFilterQuery($request);
        $companies = $this->get('knp_paginator')->paginate($companies, $request->query->getInt('page', 1), 10);

        return $this->render(
            'FrontBundle::Companies/list.html.twig',
            [
                'companies' => $companies,
                'filter' => $filter->createView(),
                'jobRepository' => $this->getDoctrine()->getRepository('AppBundle:Job'),
                'breadcrumbs' => [
                    [
                        'link' => $this->get('router')->generate('homepage'),
                        'title' => $this->get('translator')->trans('Home'),
                    ],
                    ['title' => $this->get('translator')->trans('Companies')],
                ],
            ]
        );
    }

    /**
     * @Route("/company/{id}", name="company_show", requirements={"id": "\d+"})
     * @ParamConverter("company", class="JobPlatform\AppBundle\Entity\Company")
     */
    public function showAction(Request $request, Company $company)
    {
        $jobs = $this->getDoctrine()->getRepository('AppBundle:Job')->findBy(
            [
                'company' => $company,
                'isPublished' => 1,
            ]
        );
        $recent_jobs = $this->getDoctrine()->getRepository('AppBundle:Job')->findRecent(4);
        $contactForm = $this->createForm(ContactType::class);
        $contactForm->handleRequest($request);

        if ($contactForm->isSubmitted() && $contactForm->isValid()) {
            $contact = $contactForm->getData();

            $message = \Swift_Message::newInstance()
                ->setSubject('['.$request->getSchemeAndHttpHost().'] Contact Message')
                ->setFrom($contact['email'])
                ->setTo($company->getEmail())
                ->setBody(
                    $this->renderView(
                        'FrontBundle::Emails/contact.html.twig',
                        [
                            'name' => $contact['name'],
                            'message' => $contact['message'],
                        ]
                    ),
                    'text/html'
                );


            if ($this->get('mailer')->send($message)) {
                $this->addFlash(
                    'success',
                    $this->get('translator')->trans('Thanks for posting your message. We will contact you shortly.')
                );
            } else {
                $this->addFlash(
                    'danger',
                    $this->get('translator')->trans('There was an error when sending an e-mail.')
                );
            }


            return $this->redirectToRoute('company_show', ['id' => $company->getId()]);
        }

        return $this->render(
            'FrontBundle::Companies/show.html.twig',
            [
                'contactForm' => $contactForm->createView(),
                'company' => $company,
                'jobs' => $jobs,
                'recent_jobs' => $recent_jobs,
                'breadcrumbs' => [
                    [
                        'link' => $this->get('router')->generate('homepage'),
                        'title' => $this->get('translator')->trans('Home'),
                    ],
                    [
                        'link' => $this->get('router')->generate('company_list'),
                        'title' => $this->get('translator')->trans('Companies'),
                    ],
                    [
                        'title' => $company->getName(),
                    ],
                ],
            ]
        );
    }

    /**
     * @Route("/account/companies", name="company_my")
     */
    public function myAction(Request $request)
    {
        $companies = $this->getDoctrine()->getRepository('AppBundle:Company')->findUserCompanies($this->getUser());
        $companies = $this->get('knp_paginator')->paginate($companies, $request->query->getInt('page', 1), 10);

        return $this->render(
            'FrontBundle::Companies/my.html.twig',
            [
                'companies' => $companies,
                'breadcrumbs' => [
                    [
                        'link' => $this->get('router')->generate('homepage'),
                        'title' => $this->get('translator')->trans('Home'),
                    ],
                    ['title' => $this->get('translator')->trans('My Companies')],
                ],
            ]
        );
    }

    /**
     * @Route("/account/companies/create", name="company_create")
     */
    public function createAction(Request $request)
    {
        $company = new Company();
        $form = $this->createForm(CompanyType::class, $company);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $company = $form->getData();

            $companies = $this->getUser()->getCompanies();
            $companies[] = $company;
            $this->getUser()->setCompanies($companies);

            try {
                $em = $this->getDoctrine()->getManager();
                $em->persist($company);
                $em->flush();
                $this->addFlash('success', $this->get('translator')->trans('Company has been created.'));
            } catch(\Exception $e) {
                $this->addFlash('danger', $this->get('translator')->trans('An error occurred when saving object.'));
            }


            return $this->redirectToRoute('company_my');
        }

        return $this->render(
            'FrontBundle::Companies/create.html.twig',
            [
                'form' => $form->createView(),
                'breadcrumbs' => [
                    [
                        'link' => $this->get('router')->generate('homepage'),
                        'title' => $this->get('translator')->trans('Home'),
                    ],
                    [
                        'link' => $this->get('router')->generate('company_my'),
                        'title' => $this->get('translator')->trans('My Companies'),
                    ],
                    [
                        'title' => $this->get('translator')->trans('Create Company'),
                    ],
                ],
            ]
        );
    }

    /**
     * @Route("/account/companies/update/{id}", name="company_update", requirements={"id": "\d+"})
     * @ParamConverter("company", class="JobPlatform\AppBundle\Entity\Company")
     */
    public function updateAction(Request $request, Company $company)
    {

        $form = $this->createForm(CompanyType::class, $company);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $company = $form->getData();

            try {
                $em = $this->getDoctrine()->getManager();
                $em->persist($company);
                $em->flush();
                $this->addFlash('success', $this->get('translator')->trans('Company has been successfully updated.'));
            } catch(\Exception $e) {
                $this->addFlash('danger', $this->get('translator')->trans('An error occurred when saving object.'));
            }

            return $this->redirectToRoute(
                'company_update',
                [
                    'id' => $company->getId(),
                ]
            );
        }

        return $this->render(
            'FrontBundle::Companies/update.html.twig',
            [
                'form' => $form->createView(),
                'breadcrumbs' => [
                    [
                        'link' => $this->get('router')->generate('homepage'),
                        'title' => $this->get('translator')->trans('Home'),
                    ],
                    [
                        'link' => $this->get('router')->generate('company_my'),
                        'title' => $this->get('translator')->trans('My Companies'),
                    ],
                    [
                        'title' => $this->get('translator')->trans($company->getName()),
                    ],
                ],
            ]
        );
    }

    /**
     * @Route("/account/companies/delete/{id}", name="company_delete", requirements={"id": "\d+"})
     * @ParamConverter("company", class="JobPlatform\AppBundle\Entity\Company")
     */
    public function deleteAction(Request $request, Company $company)
    {
        if (!$this->getDoctrine()->getManager()->getRepository('AppBundle:Company')->hasUserCompany(
            $this->getUser(),
            $company
        )
        ) {
            throw $this->createAccessDeniedException('You are not allowed to access this page.');
        }

        $em = $this->getDoctrine()->getManager();
        $em->remove($company);
        $em->flush();

        $this->addFlash('success', $this->get('translator')->trans('Company has been successfully deleted.'));

        return $this->redirectToRoute('company_my');
    }
}
