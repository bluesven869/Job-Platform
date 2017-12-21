<?php

namespace JobPlatform\AppBundle\Admin;

use JobPlatform\AppBundle\Entity\Profile;
use Sonata\AdminBundle\Admin\AbstractAdmin;
use Sonata\AdminBundle\Datagrid\ListMapper;
use Sonata\AdminBundle\Datagrid\DatagridMapper;
use Sonata\AdminBundle\Form\FormMapper;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Vich\UploaderBundle\Form\Type\VichImageType;


class ProfileAdmin extends AbstractAdmin
{
    protected function configureFormFields(FormMapper $formMapper)
    {
        $formMapper
            ->add('avatarImage', VichImageType::class, [
                'required' => false,
                'allow_delete' => true,
                'download_link' => true,
            ])
            ->add('firstName', 'text')
            ->add('lastName', 'text')
            ->add('user', EntityType::class, [
                'class' => 'AppBundle:User',
            ])
            ->add('visibility', ChoiceType::class, [
                'choices' => [
                    'Public' => Profile::VISIBILITY_PUBLIC,
                    'Authenticated' => Profile::VISIBILITY_AUTHENTICATED,
                    'Private' => Profile::VISIBILITY_PRIVATE,
                ],
            ]);
    }

    protected function configureDatagridFilters(DatagridMapper $datagridMapper)
    {
        $datagridMapper
            ->add('firstName')
            ->add('lastName');
    }

    protected function configureListFields(ListMapper $listMapper)
    {
        $listMapper
            ->addIdentifier('firstName')
            ->addIdentifier('lastName')
            ->addIdentifier('visibility');
    }
}
