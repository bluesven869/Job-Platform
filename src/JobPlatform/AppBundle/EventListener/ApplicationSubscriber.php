<?php

namespace JobPlatform\AppBundle\EventListener;

use Doctrine\Common\EventSubscriber;
use Doctrine\ORM\Event\LifecycleEventArgs;

use JobPlatform\AppBundle\Entity\Application;

use Symfony\Component\DependencyInjection\ContainerInterface;

class ApplicationSubscriber implements EventSubscriber
{
    private $container;

    public function __construct(ContainerInterface $container)
    {
        $this->container = $container;
    }

    public function getSubscribedEvents()
    {
        return ['postPersist',];
    }

    public function postPersist(LifecycleEventArgs $args)
    {
        /** @var Application $entity */
        $entity = $args->getEntity();

        if ($entity instanceof Application) {
            foreach ($entity->getJob()->getCompany()->getUsers() as $user) {
                $message = \Swift_Message::newInstance()
                    ->setSubject('['.$this->container->getParameter('app.project_name').'] Application Received')
                    ->setFrom($this->container->getParameter('app.email_from'))
                    ->setTo($user->getEmail())
                    ->setBody(
                        $this->container->get('templating')->render(
                            'AppBundle::Emails/application_received.html.twig',
                            [
                                'application' => $entity,
                            ]
                        ),
                        'text/html'
                    );
                $this->container->get('mailer')->send($message);
            }
        }
    }
}