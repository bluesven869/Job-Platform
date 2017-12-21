<?php

namespace JobPlatform\AppBundle\Repository;

use Doctrine\ORM\EntityRepository;
use JobPlatform\AppBundle\Entity\User;

class FavoriteRepository extends EntityRepository
{
    public function findAllForUser(User $user)
    {
        $qb = $this->createQueryBuilder('favorite');

        return $qb->innerJoin('favorite.job', 'job')
            ->andWhere('favorite.user = :user')
            ->andWhere('job.isPublished = 1')
            ->orderBy('favorite.created', 'DESC')
            ->orderBy('favorite.id', 'DESC')
            ->setParameter('user', $user)
            ->getQuery()
            ->execute();
    }
}
