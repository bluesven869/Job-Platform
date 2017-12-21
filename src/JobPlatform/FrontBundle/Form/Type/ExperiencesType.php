<?php

namespace JobPlatform\FrontBundle\Form\Type;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\CollectionType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;

class ExperiencesType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder->add('experiences', CollectionType::class, [
            'label' => false,
            'entry_options' => [
                'label' => false,
            ],
            'entry_type' => ExperienceType::class,
            'allow_add' => true,
            'allow_delete' => true,
            'prototype' => true,
            'by_reference' => false,
            'attr' => array(
                'class' => 'collection',
            ),
        ])->add('save', SubmitType::class, array(
            'attr' => array('class' => 'btn-primary'),
        ));
    }
}
