<?php

namespace JobPlatform\AppBundle\Repository;

use Doctrine\ORM\EntityRepository;
use JobPlatform\AppBundle\Entity\User;

class ApplicationRepository extends EntityRepository
{
    public function findUserApplicants(User $user)
    {
        $qb = $this->createQueryBuilder('application');

        return $qb->innerJoin('application.job', 'job')
            ->andWhere('job.company IN(:companies)')
            ->setParameter('companies', $user->getCompanies())
            ->orderBy('application.created', 'DESC')
            ->getQuery()
            ->execute();
    }

    public function findUserApplicantsByUser(User $user, User $applicant)
    {
        $qb = $this->createQueryBuilder('application');

        return $qb->innerJoin('application.job', 'job')
            ->andWhere('application.user = :applicant')
            ->andWhere('job.company IN(:companies)')
            ->setParameters(
                [
                    'companies' => $user->getCompanies(),
                    'applicant' => $applicant,
                ]
            )
            ->orderBy('application.created', 'DESC')
            ->getQuery()
            ->execute();
    }
}
