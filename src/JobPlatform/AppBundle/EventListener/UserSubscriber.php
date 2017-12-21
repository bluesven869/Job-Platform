<?php

namespace JobPlatform\AppBundle\EventListener;

use FOS\UserBundle\Event\FilterUserResponseEvent;
use FOS\UserBundle\FOSUserEvents;
use Symfony\Bundle\FrameworkBundle\Routing\Router;
use Symfony\Component\DependencyInjection\ContainerInterface;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;


class UserSubscriber implements EventSubscriberInterface
{
    private $container;

    public function __construct(ContainerInterface $container)
    {
        $this->container = $container;
    }

    public static function getSubscribedEvents()
    {
        return [
            FOSUserEvents::REGISTRATION_COMPLETED => 'onUserCreated',
        ];
    }

    public function onUserCreated(FilterUserResponseEvent $event)
    {
        $user = $event->getUser();

        $message = \Swift_Message::newInstance()
            ->setSubject('['.$this->container->getParameter('app.project_name').'] New User Registration')
            ->setFrom($this->container->getParameter('app.email_from'))
            ->setTo($user->getEmail())
            ->setBody(
                $this->container->get('templating')->render(
                    'AppBundle::Emails/user_registered.html.twig',
                    [
                        'user' => $user,
                    ]
                ),
                'text/html'
            );

        $this->container->get('mailer')->send($message);

        $response = $event->getResponse();
        $response->setTargetUrl($this->container->get('router')->generate('company_list'));
    }
}