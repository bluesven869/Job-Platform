<?php

namespace JobPlatform\FrontBundle\Form\Type;

use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\CountryType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class JobType extends AbstractType
{
    /**
     * @param FormBuilderInterface $builder
     * @param array                $options
     */
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
          ->add('name', TextType::class)
          ->add('country', CountryType::class)
          ->add('price', IntegerType::class, [
              'required' => false,
          ])
          ->add('company', EntityType::class, [
            'class' => 'AppBundle:Company',
            'choices' => $options['user']->getCompanies(),
          ])
          ->add('categories', EntityType::class, [
            'class' => 'AppBundle:Category',
            'multiple' => true,
            'required' => false,
          ])
          ->add('contract', EntityType::class, [
            'class' => 'AppBundle:Contract',
            'required' => false,
          ])
          ->add('projectType', EntityType::class, [
            'class' => 'AppBundle:ProjectType',
            'required' => false,
          ])
          ->add('description', TextareaType::class, [
              'attr' => ['class' => 'wysiwyg'],
          ])
          ->add('save', SubmitType::class, [
            'attr' => ['class' => 'btn-primary'],
          ]);
    }

    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults([
          'user' => null,
          'data_class' => 'JobPlatform\AppBundle\Entity\Job',
        ]);
    }
}
