<?php

namespace JobPlatform\AppBundle\Repository;

use Doctrine\ORM\EntityRepository;
use JobPlatform\AppBundle\Entity\Profile;

class ProfileRepository extends EntityRepository
{
    public function findByFilterQuery($request, $types = [Profile::VISIBILITY_PUBLIC])
    {
        $qb = $this->createQueryBuilder('profile');

        $qb->andWhere('profile.visibility IN(:types)')->setParameter('types', $types);

        // Keyword
        if (!empty($request->query->get('keyword'))) {
            $qb->andWhere('profile.name LIKE :filterKeyword OR profile.description LIKE :filterKeyword')
                ->setParameter('filterKeyword', '%'.$request->query->get('keyword').'%');
        }

        // Country
        if (!empty($request->query->get('country'))) {
            $qb->andWhere('profile.country = :country')
                ->setParameter('country', $request->query->get('country'));
        }

        // Verified
        if (!empty($request->query->get('is_verified'))) {
            $qb->innerJoin('profile.user', 'user')
                ->andWhere('user.isVerified = 1');
        }

        return $qb->addOrderBy('profile.created', 'DESC')
            ->getQuery()
            ->execute();
    }
}
