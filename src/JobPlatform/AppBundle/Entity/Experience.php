<?php

namespace JobPlatform\AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity
 * @ORM\Table(name="job_platform_experiences")
 * @ORM\HasLifecycleCallbacks()
 */
class Experience
{
    /**
     * @ORM\Id
     * @ORM\Column(type="integer")
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    protected $id;

    /**
     * @ORM\ManyToOne(targetEntity="User", inversedBy="experiences")
     * @ORM\JoinColumn(name="user_id", referencedColumnName="id")
     */
    private $user;

    /**
     * @ORM\Column(type="string", length=255, name="company_name")
     */
    private $companyName;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $name;

    /**
     * @ORM\Column(type="integer", name="month_from")
     */
    private $monthFrom;

    /**
     * @ORM\Column(type="integer", name="year_from")
     */
    private $yearFrom;

    /**
     * @ORM\Column(type="integer", name="month_to")
     */
    private $monthTo;

    /**
     * @ORM\Column(type="integer", name="year_to")
     */
    private $yearTo;

    /**
     * @ORM\Column(type="text", nullable=true)
     */
    private $description;

    /**
     * @ORM\Column(name="created", type="datetime")
     */
    private $created;

    /**
     * @ORM\Column(name="modified", type="datetime", nullable=true)
     */
    private $modified;

    /**
     * @ORM\PrePersist
     */
    public function onPrePersist()
    {
        $this->created = new \DateTime('now');
    }

    /**
     * @ORM\PreUpdate
     */
    public function onPreUpdate()
    {
        $this->modified = new \DateTime('now');
    }

    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * @param mixed $id
     */
    public function setId($id)
    {
        $this->id = $id;
    }

    /**
     * @return mixed
     */
    public function getUser()
    {
        return $this->user;
    }

    /**
     * @param mixed $user
     */
    public function setUser($user)
    {
        $this->user = $user;
    }

    /**
     * @return mixed
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * @param mixed $name
     */
    public function setName($name)
    {
        $this->name = $name;
    }

    /**
     * @return mixed
     */
    public function getDescription()
    {
        return $this->description;
    }

    /**
     * @param mixed $description
     */
    public function setDescription($description)
    {
        $this->description = $description;
    }

    /**
     * @return mixed
     */
    public function getYearFrom()
    {
        return $this->yearFrom;
    }

    /**
     * @param mixed $yearFrom
     */
    public function setYearFrom($yearFrom)
    {
        $this->yearFrom = $yearFrom;
    }

    /**
     * @return mixed
     */
    public function getYearTo()
    {
        return $this->yearTo;
    }

    /**
     * @param mixed $yearTo
     */
    public function setYearTo($yearTo)
    {
        $this->yearTo = $yearTo;
    }

    /**
     * @return mixed
     */
    public function getMonthFrom()
    {
        return $this->monthFrom;
    }

    /**
     * @param mixed $monthFrom
     */
    public function setMonthFrom($monthFrom)
    {
        $this->monthFrom = $monthFrom;
    }

    /**
     * @return mixed
     */
    public function getMonthTo()
    {
        return $this->monthTo;
    }

    /**
     * @param mixed $monthTo
     */
    public function setMonthTo($monthTo)
    {
        $this->monthTo = $monthTo;
    }

    /**
     * @return mixed
     */
    public function getCompanyName()
    {
        return $this->companyName;
    }

    /**
     * @param mixed $companyName
     */
    public function setCompanyName($companyName)
    {
        $this->companyName = $companyName;
    }
}
