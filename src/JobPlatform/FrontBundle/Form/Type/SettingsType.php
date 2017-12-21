<?php

namespace JobPlatform\FrontBundle\Form\Type;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class SettingsType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('visibility', ChoiceType::class, [
                'required' => true,
                'choices' => [
                    'Public' => 'public',
                    'Authenticated' => 'authenticated',
                    'Private' => 'private',
                ],
            ])
            ->add('save', SubmitType::class, array(
                'attr' => array('class' => 'btn-primary'),
            ));
    }

    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults([
            'data_class' => 'JobPlatform\AppBundle\Entity\Profile',
        ]);
    }
}
