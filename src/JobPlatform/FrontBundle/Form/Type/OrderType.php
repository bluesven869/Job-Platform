<?php

namespace JobPlatform\FrontBundle\Form\Type;

use JobPlatform\AppBundle\Repository\CompanyRepository;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\CountryType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class OrderType extends AbstractType
{
    /**
     * @param FormBuilderInterface $builder
     * @param array                $options
     */
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $choices = [];
        foreach ($options['gateways'] as $gateway) {
            if ($gateway['enabled']) {
                $choices[$gateway['name']] = $gateway['id'];
            }
        }

        $builder
            ->add('gateway', ChoiceType::class, [
                'label' => false,
                'required' => true,
                'multiple' => false,
                'expanded' => true,
                'choices' => $choices,
            ])
            ->add('company', EntityType::class, [
                'class' => 'AppBundle:Company',
                'query_builder' => function (CompanyRepository $repository) use ($options) {
                    return $repository->findUserCompaniesQueryBuilder($options['user']);
                },
            ])
            ->add('companyName', TextType::class)
            ->add('regNo', TextType::class)
            ->add('vatNo', TextType::class)
            ->add('country', CountryType::class)
            ->add('county', TextType::class)
            ->add('city', TextType::class)
            ->add('street', TextType::class)
            ->add('postalCode', TextType::class)
            ->add('save', SubmitType::class, array(
                'label' => 'Save Order & Process Payment',
                'attr' => array('class' => 'btn-primary btn-block'),
            ));
    }

    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults([
            'user' => null,
            'gateways' => null,
            'data_class' => 'JobPlatform\AppBundle\Entity\Order',
        ]);
    }
}
