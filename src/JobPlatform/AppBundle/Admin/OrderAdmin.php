<?php

namespace JobPlatform\AppBundle\Admin;

use JobPlatform\AppBundle\Entity\Order;
use Sonata\AdminBundle\Admin\AbstractAdmin;
use Sonata\AdminBundle\Datagrid\ListMapper;
use Sonata\AdminBundle\Datagrid\DatagridMapper;
use Sonata\AdminBundle\Form\FormMapper;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;


class OrderAdmin extends AbstractAdmin
{
    protected function configureFormFields(FormMapper $formMapper)
    {
        $formMapper
            ->add('id', 'text')
            ->add('price', 'text')
	        ->add('gateway', 'text')
	        ->add('companyName', 'text')
	        ->add('regNo', 'text')
	        ->add('vatNo', 'text')
	        ->add('country', 'text')
	        ->add('county', 'text')
	        ->add('city', 'text')
	        ->add('street', 'text')
	        ->add('postalCode', 'text')
            ->add('currency', 'text')
            ->add('status', ChoiceType::class, [
                'choices' => [
                    'New' => Order::STATUS_NEW,
                    'Completed' => Order::STATUS_COMPLETED,
                    'Canceled' => Order::STATUS_CANCELED,
                ],
            ])
            ->add(
                'company',
                'entity',
                [
                    'class' => 'JobPlatform\AppBundle\Entity\Company',
                ]
            )->end();
    }

    protected function configureDatagridFilters(DatagridMapper $datagridMapper)
    {
        $datagridMapper->add('id');
    }

    protected function configureListFields(ListMapper $listMapper)
    {
        $listMapper
            ->addIdentifier('id');
    }
}
