<?php

namespace JobPlatform\FrontBundle\Form\Type;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\CheckboxType;
use Symfony\Component\Form\Extension\Core\Type\CountryType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\OptionsResolver\OptionsResolver;

class FilterProfileType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('keyword', TextType::class, [
                'label' => false,
                'required' => false,
                'attr' => ['placeholder' => 'Search by keyword'],
            ])
            ->add('country', CountryType::class, [
                'required' => false,
            ])
            ->add('is_verified', CheckboxType::class, [
                'label' => 'Verified candidates only',
                'required' => false,
            ])
            ->add('save', SubmitType::class, [
                'label' => 'Filter Candidates',
                'attr' => ['class' => 'btn-primary btn-block'],
            ])
            ->setMethod('GET')
            ->setAction($options['router']->generate('profile_list'));
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
