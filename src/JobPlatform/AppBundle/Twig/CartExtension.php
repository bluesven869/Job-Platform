<?php

namespace JobPlatform\AppBundle\Twig;

class CartExtension extends \Twig_Extension
{
    /**
     * @return array
     */
    public function getFunctions()
    {
        return array(
            new \Twig_SimpleFunction('cart_get_count', [$this, 'getCount'], ['needs_environment' => true]),
            new \Twig_SimpleFunction('cart_get_price', [$this, 'getPrice'], ['needs_environment' => true]),
        );
    }

    /**
     * @param \Twig_Environment $env
     * @return int
     */
    public function getCount(\Twig_Environment $env) {
        $request = $env->getGlobals()['app']->getRequest();
        $products = $request->getSession()->get('products');

        if ($products) {
            return count($products);
        }

        return 0;
    }

    /**
     * @param \Twig_Environment $env
     * @return int
     */
    public function getPrice(\Twig_Environment $env) {
        $request = $env->getGlobals()['app']->getRequest();
        $products = $request->getSession()->get('products');

        if ($products) {
            $price = 0;
            foreach($products as $product) {
                $price += $product['price'];
            }

            return $price;
        }

        return 0;
    }

    /**
     * @return string
     */
    public function getName()
    {
        return 'cart_extension';
    }
}