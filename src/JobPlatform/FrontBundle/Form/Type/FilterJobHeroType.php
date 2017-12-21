<?php

namespace JobPlatform\FrontBundle\Form\Type;

use JobPlatform\AppBundle\Repository\CategoryRepository;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\OptionsResolver\OptionsResolver;

class FilterJobHeroType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
          ->add('categories', EntityType::class, [
            'class' => 'AppBundle:Category',
            'query_builder' => function (CategoryRepository $repository) {
                return $repository->findAllOrderedByName();
            },
            'required' => false,
            'placeholder' => 'Select Category',
          ])
          ->add('contracts', EntityType::class, [
            'label' => 'Contracts',
            'class' => 'AppBundle:Contract',
            'required' => false,
            'placeholder' => 'Select Contract',
          ])
          ->add('project_types', EntityType::class, [
            'label' => 'Project Types',
            'class' => 'AppBundle:ProjectType',
            'required' => false,
            'placeholder' => 'Select Project Type',
          ])
          ->add('save', SubmitType::class, [
            'label' => 'Filter Jobs',
            'attr' => ['class' => 'btn-primary btn-block'],
          ])->setMethod('GET')->setAction($options['router']->generate('job_list'));
    }

    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults([
            'router' => null,
            'csrf_protection' => false,
        ]);
    }

    public function getBlockPrefix()
    {
        return null;
    }
}
