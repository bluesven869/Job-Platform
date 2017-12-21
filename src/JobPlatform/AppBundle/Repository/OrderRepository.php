<?php

namespace JobPlatform\AppBundle\Repository;

use Doctrine\ORM\EntityRepository;

class OrderRepository extends EntityRepository
{
    public function findAllByUser($user)
    {
        $qb = $this->createQueryBuilder('orders');

        return $qb->andWhere('orders.company IN(:companies)')
            ->setParameter('companies', $user->getCompanies())
            ->orderBy('orders.created', 'DESC')
            ->getQuery()
            ->execute();
    }

    public function getInvoiceId($order)
    {
        $qb = $this->createQueryBuilder('orders');
        $date = date_create(date('Y')."-01-01");
        $fromDate = date_format($date, "Y/m/d H:i:s");

        $orders = $qb->andWhere('orders.created BETWEEN :fromDate AND :orderDate')
            ->setParameters(
                [
                    'fromDate' => $fromDate,
                    'orderDate' => $order->getCreated(),
                ]
            )
            ->getQuery()
            ->execute();

        $number = str_pad(count($orders), 5, '0', STR_PAD_LEFT);

        return date('Y').$number;
    }
}
