<?php

namespace JobPlatform\AppBundle\DependencyInjection;

use Symfony\Component\Config\Definition\Builder\TreeBuilder;
use Symfony\Component\Config\Definition\ConfigurationInterface;

class Configuration implements ConfigurationInterface
{
    public function getConfigTreeBuilder()
    {
        $treeBuilder = new TreeBuilder();
        $rootNode = $treeBuilder->root('app');

        $rootNode
            ->children()
                ->scalarNode('project_name')->defaultValue('Job Platform Project')->end()
                ->scalarNode('currency')->defaultValue('USD')->end()
                ->scalarNode('email_from')->defaultValue('info@example.com')->end()

                ->arrayNode('payments')
                    ->addDefaultsIfNotSet()
                    ->children()
                        ->arrayNode('pay_for_featured')
                            ->addDefaultsIfNotSet()
                            ->children()
                                ->scalarNode('enabled')->defaultValue(false)->end()
                                ->scalarNode('price')->defaultValue(9.90)->end()
                                ->scalarNode('duration')->defaultValue(10)->end()
                            ->end()
                        ->end()
                        ->arrayNode('pay_for_publish')
                            ->addDefaultsIfNotSet()
                            ->children()
                                ->booleanNode('enabled')->defaultValue(false)->end()
                                ->floatNode('price')->defaultValue(19.90)->end()
                                ->integerNode('duration')->defaultValue(10)->end()
                            ->end()
                        ->end()
                    ->end()
                ->end()

                ->arrayNode('gateways')
                    ->addDefaultsIfNotSet()
                    ->children()
                        ->arrayNode('wire')
                            ->addDefaultsIfNotSet()
                            ->children()
                                ->scalarNode('enabled')->defaultValue(false)->end()
                                ->scalarNode('id')->defaultValue('wire')->end()
                                ->scalarNode('name')->defaultValue('Wire Transfer')->end()
                            ->end()
                        ->end()
                        ->arrayNode('paypal')
                            ->addDefaultsIfNotSet()
                            ->children()
                                ->scalarNode('enabled')->defaultValue(false)->end()
                                ->scalarNode('id')->defaultValue('paypal')->end()
                                ->scalarNode('name')->defaultValue('PayPal Express Checkout')->end()
                            ->end()
                        ->end()
                    ->end()
                ->end()

                ->arrayNode('invoicing')
                    ->addDefaultsIfNotSet()
                    ->children()
                        ->scalarNode('full_name')->defaultValue('Example Company Name')->end()
                        ->scalarNode('reg_no')->defaultValue('Example Registration Number')->end()
                        ->scalarNode('vat_no')->defaultValue('Example VAT Number')->end()
                        ->scalarNode('street')->defaultValue('Example Street / P.O.Box')->end()
                        ->scalarNode('postal_code')->defaultValue('Example Postal Code')->end()
                        ->scalarNode('city')->defaultValue('Example City')->end()
                        ->scalarNode('country')->defaultValue('Example Country')->end()
                        ->scalarNode('bank_name')->defaultValue('Example Name')->end()
                        ->scalarNode('bank_account')->defaultValue('Example Bank Account')->end()
                        ->scalarNode('bank_iban')->defaultValue('Example Bank IBAN')->end()
                        ->scalarNode('bank_swift')->defaultValue('Example Bank Swift')->end()
                        ->scalarNode('bank_code')->defaultValue('Example Bank Code')->end()
                        ->scalarNode('notice')->defaultValue('Example Notice')->end()
                        ->scalarNode('constant_symbol')->defaultValue('Example Constant Symbol')->end()
                        ->integerNode('days_due')->defaultValue(14)->end()
                    ->end()
                ->end()
            ->end()
        ;

        return $treeBuilder;
    }
}