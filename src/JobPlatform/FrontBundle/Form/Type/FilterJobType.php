<?php

namespace JobPlatform\FrontBundle\Form\Type;

use JobPlatform\AppBundle\Repository\CategoryRepository;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\CountryType;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\OptionsResolver\OptionsResolver;

class FilterJobType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
        ->add('keyword', HiddenType::class, [
            'label' => false,
            'required' => false,
        ])
        ->add('price_from', IntegerType::class, [
            'label' => 'Price',
            'required' => false,
        ])
        ->add('price_to', IntegerType::class, [
            'label' => false,
            'required' => false,
        ])
        ->add('categories', EntityType::class, [
            'attr' => [
                'class' => 'selectpicker',
                'data-selected-text-format' => 'count > 3',
            ],
            'class' => 'AppBundle:Category',
            'query_builder' => function (CategoryRepository $repository) {
                return $repository->findAllOrderedByName();
            },
            'required' => false,
            'expanded' => false,
            'multiple' => true,
        ])
        ->add('country', CountryType::class, [
            'required' => false,
        ])
        ->add('contracts', EntityType::class, [
            'label' => 'Contracts',
            'class' => 'AppBundle:Contract',
            'multiple' => true,
            'expanded' => true,
            'required' => false,
        ])
        ->add('project_types', EntityType::class, [
            'label' => 'Project Types',
            'class' => 'AppBundle:ProjectType',
            'multiple' => true,
            'expanded' => true,
            'required' => false,
        ])
        ->add('save', SubmitType::class, [
            'label' => 'Filter Jobs',
            'attr' => ['class' => 'btn-primary btn-block'],
        ])
        ->setMethod('GET')
        ->setAction($options['router']->generate('job_list'));
    }

    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults([
            'router' => null,
            'csrf_protection' => false,
            'allow_extra_fields' => true,
        ]);
    }

    public function getBlockPrefix()
    {
        return null;
    }
}
