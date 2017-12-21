<?php

namespace JobPlatform\AppBundle\Repository;

use Doctrine\ORM\EntityRepository;

class CompanyRepository extends EntityRepository
{
    public function findUserCompanies($user)
    {
        $qb = $this->createQueryBuilder('company');

        return $qb->innerJoin('company.users', 'user')
            ->andWhere('user.id = :user')
            ->setParameter('user', $user)
            ->orderBy('company.created', 'DESC')
            ->getQuery()
            ->execute();
    }

    public function findUserCompaniesQueryBuilder($user)
    {
        $qb = $this->createQueryBuilder('company');

        return $qb->innerJoin('company.users', 'user')
            ->andWhere('user.id = :user')
            ->setParameter('user', $user)
            ->orderBy('company.created', 'DESC');
    }

    public function hasUserCompany($user, $company)
    {
        $qb = $this->createQueryBuilder('company');

        $results = $qb->innerJoin('company.users', 'user')
            ->andWhere('user.id = :user')
            ->andWhere('company.id = :company')
            ->setParameters(
                [
                    'user' => $user,
                    'company' => $company,
                ]
            )
            ->getQuery()
            ->getResult();

        if (1 === count($results)) {
            return true;
        }

        return false;
    }

    public function findByFilterQuery($request)
    {
        $qb = $this->createQueryBuilder('company');

        // Keyword
        if (!empty($request->query->get('keyword'))) {
            $qb->andWhere('company.name LIKE :filterKeyword OR company.description LIKE :filterKeyword')
                ->setParameter('filterKeyword', '%'.$request->query->get('keyword').'%');
        }

        // Country
        if (!empty($request->query->get('country'))) {
            $qb->andWhere('company.country = :country')->setParameter('country', $request->query->get('country'));
        }

        return $qb->addOrderBy('company.created', 'DESC')
            ->getQuery()
            ->execute();
    }
}
