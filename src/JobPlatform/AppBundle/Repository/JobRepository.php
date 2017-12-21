<?php

namespace JobPlatform\AppBundle\Repository;

use Doctrine\ORM\EntityRepository;
use JobPlatform\AppBundle\Entity\Job;
use JobPlatform\AppBundle\Entity\User;

class JobRepository extends EntityRepository
{
    public function unfeature()
    {
        $qb = $this->createQueryBuilder('job');

        return $qb->update()
            ->set('job.isFeatured', '0')
            ->andWhere('job.featuredUntil > CURRENT_TIMESTAMP()')
            ->getQuery()
            ->execute();
    }

    public function unpublish()
    {
        $qb = $this->createQueryBuilder('job');

        return $qb->update()
            ->set('job.isPublished', '0')
            ->andWhere('job.publishedUntil > CURRENT_TIMESTAMP()')
            ->getQuery()
            ->execute();
    }

    public function getCompanyCount($company)
    {
        $qb = $this->createQueryBuilder('job');
        $results = $qb->andWhere('job.company = :company')
            ->andWhere('job.isPublished = 1')
            ->setParameter('company', $company)
            ->getQuery()
            ->execute();

        return count($results);
    }

    /**
     * @param User $user
     * @param Job $job
     * @return bool
     */
    public function hasUserJob($user, $job)
    {
        if (!$user) {
            return false;
        }
        $qb = $this->createQueryBuilder('job');

        $results = $qb->andWhere('job.company IN(:companies)')
            ->andWhere('job.id = :job')
            ->setParameters(
                [
                    'companies' => $user->getCompanies(),
                    'job' => $job,
                ]
            )
            ->getQuery()
            ->getResult();

        if (1 === count($results)) {
            return true;
        }

        return false;
    }

    public function findRecent($count = 8)
    {
        $qb = $this->createQueryBuilder('job');

        return $qb->andWhere('job.isPublished = 1')
            ->orderBy('job.created', 'DESC')
            ->setMaxResults($count)
            ->getQuery()
            ->execute();
    }

    public function findByCategorySlug($slug)
    {
        $qb = $this->createQueryBuilder('job');
        return $qb->innerJoin('job.categories', 'category')
            ->andWhere('category.slug = :slug')
            ->setParameter('slug', $slug)
            ->andWhere('job.isPublished = 1')
            ->addOrderBy('job.isFeatured', 'DESC')
            ->addOrderBy('job.created', 'DESC')
            ->getQuery()
            ->execute();
    }

    public function findUserJobs(User $user)
    {
        if (!$user) {
            return false;
        }

        $qb = $this->createQueryBuilder('job');

        return $qb->andWhere('job.company IN(:companies)')
            ->setParameter('companies', $user->getCompanies())
            ->orderBy('job.created', 'DESC')
            ->addOrderBy('job.id', 'DESC')
            ->getQuery()
            ->execute();
    }

    public function findByFilterQuery($request)
    {
        $qb = $this->createQueryBuilder('job');
        $qb->andWhere('job.isPublished = 1');

        // Keyword
        if (!empty($request->query->get('keyword'))) {
            $qb->andWhere('job.name LIKE :filterKeyword OR job.description LIKE :filterKeyword')
                ->setParameter('filterKeyword', '%'.$request->query->get('keyword').'%');
        }

        // Price from
        if (!empty($request->query->get('price_from'))) {
            $qb->andWhere('job.price >= :priceFrom')
                ->setParameter('priceFrom', $request->query->get('price_from'));
        }

        // Price to
        if (!empty($request->query->get('price_to'))) {
            $qb->andWhere('job.price <= :priceTo')
                ->setParameter('priceTo', $request->query->get('price_to'));
        }

        // Categories
        if (!empty($request->query->get('categories'))) {
            $qb->leftJoin('job.categories', 'categories')
                ->andWhere('categories.id IN(:categories)')
                ->setParameter('categories', $request->query->get('categories'));
        }

        // Country
        if (!empty($request->query->get('country'))) {
            $qb->andWhere('job.country = :country')
                ->setParameter('country', $request->query->get('country'));
        }

        // Contracts
        if (!empty($request->query->get('contracts'))) {
            $qb->leftJoin('job.contract', 'contract')
                ->andWhere('contract.id IN(:contracts)')
                ->setParameter('contracts', $request->query->get('contracts'));
        }

        // Project types
        if (!empty($request->query->get('project_types'))) {
            $qb->leftJoin('job.projectType', 'projectType')
                ->andWhere('projectType.id IN(:projectTypes)')
                ->setParameter('projectTypes', $request->query->get('project_types'));
        }

        return $qb->addOrderBy('job.isFeatured', 'DESC')
            ->addOrderBy('job.created', 'DESC')
            ->getQuery()
            ->execute();
    }
}
