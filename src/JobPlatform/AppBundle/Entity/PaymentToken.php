<?php

namespace JobPlatform\AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;
use Payum\Core\Model\Token;

/**
 * @ORM\Table(name="job_platform_payment_tokens")
 * @ORM\Entity()
 */
class PaymentToken extends Token
{
}
