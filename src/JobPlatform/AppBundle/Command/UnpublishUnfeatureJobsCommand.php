<?php

namespace JobPlatform\AppBundle\Command;

use Symfony\Bundle\FrameworkBundle\Command\ContainerAwareCommand;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

class UnpublishUnfeatureJobsCommand extends ContainerAwareCommand
{
    protected function configure()
    {
        $this->setName('job-platform:unpublish-unfeature-jobs');
    }

    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $this->getContainer()->get('doctrine')->getManager()->getRepository('AppBundle:Job')->unfeature();
        $this->getContainer()->get('doctrine')->getManager()->getRepository('AppBundle:Job')->unpublish();
    }
}