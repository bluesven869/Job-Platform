<?php

namespace JobPlatform\AppBundle\Admin;

use Sonata\AdminBundle\Admin\AbstractAdmin;
use Sonata\AdminBundle\Datagrid\ListMapper;
use Sonata\AdminBundle\Datagrid\DatagridMapper;
use Sonata\AdminBundle\Form\FormMapper;

class JobAdmin extends AbstractAdmin
{
    protected function configureFormFields(FormMapper $formMapper)
    {
        $formMapper
            ->add('name', 'text')
            ->add('description', 'textarea')
            ->add('isPublished')
            ->add('isFeatured')
            ->add(
                'categories',
                'sonata_type_model',
                [
                    'label' => 'Choose Categories',
                    'class' => 'AppBundle:Category',
                    'expanded' => true,
                    'multiple' => true,
                    'by_reference' => false,
                ]
            )
            ->add(
                'company',
                'entity',
                [
                    'class' => 'JobPlatform\AppBundle\Entity\Company',
                ]
            )->add(
                'user',
                'entity',
                [
                    'class' => 'JobPlatform\AppBundle\Entity\User',
                ]
            )->end();
    }

    protected function configureDatagridFilters(DatagridMapper $datagridMapper)
    {
        $datagridMapper->add('name');
    }

    protected function configureListFields(ListMapper $listMapper)
    {
        $listMapper
            ->addIdentifier('name')->addIdentifier('isPublished');
    }
}
