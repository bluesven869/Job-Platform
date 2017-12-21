<?php

namespace JobPlatform\FrontBundle\Controller;

use Doctrine\Common\Collections\ArrayCollection;
use JobPlatform\AppBundle\Entity\Profile;
use JobPlatform\FrontBundle\Form\Type\EducationsType;
use JobPlatform\FrontBundle\Form\Type\ExperiencesType;
use JobPlatform\FrontBundle\Form\Type\FilterProfileType;
use JobPlatform\FrontBundle\Form\Type\ProfileType;
use JobPlatform\FrontBundle\Form\Type\SettingsType;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\ParamConverter;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;

class ProfileController extends Controller
{
    /**
     * @Route("/candidates", name="profile_list")
     */
    public function listAction(Request $request)
    {
        if ($this->getUser()) {
            $types = [Profile::VISIBILITY_PUBLIC, Profile::VISIBILITY_AUTHENTICATED];
        } else {
            $types = [Profile::VISIBILITY_PUBLIC];
        }

        $profiles = $this->getDoctrine()->getRepository('AppBundle:Profile')->findByFilterQuery($request, $types);
        $profiles = $this->get('knp_paginator')->paginate($profiles, $request->query->getInt('page', 1), 10);

        $filter = $this->createForm(FilterProfileType::class, [], ['router' => $this->get('router')]);
        $filter->handleRequest($request);

        return $this->render(
            'FrontBundle::Profiles/list.html.twig',
            [
                'profiles' => $profiles,
                'filter' => $filter->createView(),
                'breadcrumbs' => [
                    [
                        'link' => $this->get('router')->generate('homepage'),
                        'title' => $this->get('translator')->trans('Home'),
                    ],
                    ['title' => $this->get('translator')->trans('Candidates')],
                ],
            ]
        );
    }

    /**
     * @Route("/candidate/{id}", name="profile_show", requirements={"id": "\d+"})
     * @ParamConverter("profile", class="JobPlatform\AppBundle\Entity\Profile")
     */
    public function showAction(Request $request, Profile $profile)
    {
        if (Profile::VISIBILITY_PRIVATE == $profile->getVisibility()) {
            if (!$this->getUser()) {
                throw $this->createAccessDeniedException('You are not allowed to access this page.');
            }

            $applicants = $this->getDoctrine()->getRepository('AppBundle:Application')->findUserApplicantsByUser(
                $this->getUser(),
                $profile->getUser()
            );

            if (0 === count($applicants)) {
                throw $this->createAccessDeniedException('You are not allowed to access this page.');
            }
        } elseif (Profile::VISIBILITY_AUTHENTICATED == $profile->getVisibility()) {
            if (!$this->getUser()) {
                throw $this->createAccessDeniedException('You are not allowed to access this page.');
            }
        }

        return $this->render(
            'FrontBundle::Profiles/show.html.twig',
            [
                'profile' => $profile,
                'jobs' => $this->getDoctrine()->getRepository('AppBundle:Job')->findRecent(3),
                'breadcrumbs' => [
                    [
                        'link' => $this->get('router')->generate('homepage'),
                        'title' => $this->get('translator')->trans('Home'),
                    ],
                    [
                        'link' => $this->get('router')->generate('profile_list'),
                        'title' => $this->get('translator')->trans('Candidates'),
                    ],
                    [
                        'title' => $profile->getDisplayName(),
                    ],
                ],
            ]
        );
    }

    /**
     * @Route("/account/settings", name="profile_settings")
     */
    public function settingsAction(Request $request)
    {
        $profile = $this->getDoctrine()->getRepository('AppBundle:Profile')->findOneBy(
            ['user' => $this->getUser()->getId()]
        );

        $form = $this->createForm(SettingsType::class, $profile);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $profile = $form->getData();
            $profile->setUser($this->getUser());

            try {
                $em = $this->getDoctrine()->getManager();
                $em->persist($profile);
                $em->flush();
                $this->addFlash('success', $this->get('translator')->trans('Settings has been successfully saved.'));
            } catch(\Exception $e) {
                $this->addFlash('danger', $this->get('translator')->trans('An error occured when saving object.'));
            }


            return $this->redirectToRoute('profile_settings');
        }

        return $this->render(
            'FrontBundle::Profiles/settings.html.twig',
            [
                'form' => $form->createView(),
                'breadcrumbs' => [
                    [
                        'link' => $this->get('router')->generate('homepage'),
                        'title' => $this->get('translator')->trans('Home'),
                    ],
                    [
                        'title' => $this->get('translator')->trans('User'),
                    ],
                    [
                        'title' => $this->get('translator')->trans('Settings'),
                    ],
                ],
            ]
        );
    }

    /**
     * @Route("/account/profile", name="profile_update_general")
     */
    public function updateGeneralAction(Request $request)
    {
        $profile = $this->getDoctrine()->getRepository('AppBundle:Profile')->findOneBy(
            ['user' => $this->getUser()->getId()]
        );

        $form = $this->createForm(ProfileType::class, $profile);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $profile = $form->getData();
            $profile->setUser($this->getUser());

            try {
                $em = $this->getDoctrine()->getManager();
                $em->persist($profile);
                $em->flush();
                $this->addFlash('success', $this->get('translator')->trans('Profile has been successfully saved.'));
            } catch(\Exception $e) {
                $this->addFlash('danger', $this->get('translator')->trans('An error occurred when saving object.'));
            }


            return $this->redirectToRoute('profile_update_general');
        }

        return $this->render(
            'FrontBundle::Profiles/update_general.html.twig',
            [
                'form' => $form->createView(),
                'breadcrumbs' => [
                    [
                        'link' => $this->get('router')->generate('homepage'),
                        'title' => $this->get('translator')->trans('Home'),
                    ],
                    [
                        'link' => $this->get('router')->generate('profile_update_general'),
                        'title' => $this->get('translator')->trans('Profile'),
                    ],
                    [
                        'title' => $this->get('translator')->trans('General'),
                    ],
                ],
            ]
        );
    }

    /**
     * @Route("/account/profile/education", name="profile_update_education")
     */
    public function updateEducationAction(Request $request)
    {
        $educations = $this->getDoctrine()->getRepository('AppBundle:Education')->findBy(
            ['user' => $this->getUser()->getId()]
        );

        $form = $this->createForm(EducationsType::class, ['educations' => $educations]);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $user = $this->getUser();
            $em = $this->getDoctrine()->getManager();

            $originalEducations = new ArrayCollection();
            foreach ($user->getEducations() as $education) {
                $originalEducations->add($education);
            }

            $newEducations = new ArrayCollection();
            foreach ($form->getData()['educations'] as $education) {
                $education->setUser($user);
                $newEducations->add($education);
            }

            foreach ($originalEducations as $education) {
                if (false === $newEducations->contains($education)) {
                    $em->remove($education);
                }
            }

            $user->setEducations($newEducations);

            try {
                $em->persist($user);
                $em->flush();
                $this->addFlash('success', $this->get('translator')->trans('Education has been successfully saved.'));
            } catch(\Exception $e) {
                $this->addFlash('danger', $this->get('translator')->trans('An error occurred when saving object.'));
            }


            return $this->redirectToRoute('profile_update_education');
        }

        return $this->render(
            'FrontBundle::Profiles/update_education.html.twig',
            [
                'form' => $form->createView(),
                'breadcrumbs' => [
                    [
                        'link' => $this->get('router')->generate('homepage'),
                        'title' => $this->get('translator')->trans('Home'),
                    ],
                    [
                        'link' => $this->get('router')->generate('profile_update_general'),
                        'title' => $this->get('translator')->trans('Profile'),
                    ],
                    [
                        'title' => $this->get('translator')->trans('Education'),
                    ],
                ],
            ]
        );
    }

    /**
     * @Route("/account/profile/experience", name="profile_update_experience")
     */
    public function updateExperienceAction(Request $request)
    {
        $experiences = $this->getDoctrine()->getRepository('AppBundle:Experience')->findBy(
            ['user' => $this->getUser()->getId()]
        );

        $form = $this->createForm(ExperiencesType::class, ['experiences' => $experiences]);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $user = $this->getUser();
            $em = $this->getDoctrine()->getManager();

            $originalExperiences = new ArrayCollection();
            foreach ($user->getExperiences() as $experience) {
                $originalExperiences->add($experience);
            }

            $newExperiences = new ArrayCollection();
            foreach ($form->getData()['experiences'] as $experience) {
                $experience->setUser($user);
                $newExperiences->add($experience);
            }

            foreach ($originalExperiences as $experience) {
                if (false === $newExperiences->contains($experience)) {
                    $em->remove($experience);
                }
            }

            $user->setExperiences($newExperiences);

            try {
                $em->persist($user);
                $em->flush();
                $this->addFlash('success', $this->get('translator')->trans('Experience has been successfully saved.'));
            } catch(\Exception $e) {
                $this->addFlash('danger', $this->get('translator')->trans('An error occurred when saving object.'));
            }

            return $this->redirectToRoute('profile_update_experience');
        }

        return $this->render(
            'FrontBundle::Profiles/update_experience.html.twig',
            [
                'form' => $form->createView(),
                'breadcrumbs' => [
                    [
                        'link' => $this->get('router')->generate('homepage'),
                        'title' => $this->get('translator')->trans('Home'),
                    ],
                    [
                        'link' => $this->get('router')->generate('profile_update_general'),
                        'title' => $this->get('translator')->trans('Profile'),
                    ],
                    [
                        'title' => $this->get('translator')->trans('Experience'),
                    ],
                ],
            ]
        );
    }
}
