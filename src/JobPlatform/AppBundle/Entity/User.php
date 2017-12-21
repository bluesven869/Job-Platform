<?php

namespace JobPlatform\AppBundle\Entity;

use Doctrine\Common\Collections\ArrayCollection;
use FOS\UserBundle\Model\User as BaseUser;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass="JobPlatform\AppBundle\Repository\UserRepository")
 * @ORM\Table(name="job_platform_users")
 * @ORM\HasLifecycleCallbacks()
 */
class User extends BaseUser
{
    /**
     * @ORM\Id
     * @ORM\Column(type="integer")
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    protected $id;

    /**
     * @ORM\OneToOne(targetEntity="Profile", mappedBy="user")
     **/
    private $profile;

    /**
     * @ORM\OneToMany(targetEntity="Education", mappedBy="user", cascade={"persist"}, orphanRemoval=true)
     */
    private $educations;

    /**
     * @ORM\OneToMany(targetEntity="Experience", mappedBy="user", cascade={"persist"}, orphanRemoval=true)
     */
    private $experiences;

    /**
     * @ORM\ManyToMany(targetEntity="Company", inversedBy="companies")
     * @ORM\JoinTable(name="job_platform_user_company")
     */
    private $companies;

    /**
     * @ORM\Column(type="boolean", nullable=true, name="is_verified")
     */
    private $isVerified;

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

    public function getUsername() {
        return $this->username;
    }

    /**
     * @return mixed
     */
    public function getProfile()
    {
        return $this->profile;
    }

    /**
     * @param mixed $profile
     */
    public function setProfile($profile)
    {
        $this->profile = $profile;
    }

    /**
     * @return mixed
     */
    public function getCompanies()
    {
        return $this->companies;
    }

    /**
     * @param mixed $companies
     */
    public function setCompanies($companies)
    {
        $this->companies = $companies;
    }

    public function __construct()
    {
        parent::__construct();

        $this->educations = new ArrayCollection();
        $this->experiences = new ArrayCollection();
        $this->companies = new ArrayCollection();
    }

    /**
     * @return mixed
     */
    public function getEducations()
    {
        return $this->educations;
    }

    /**
     * @param mixed $educations
     */
    public function setEducations($educations)
    {
        $this->educations = $educations;
    }

    /**
     * @return mixed
     */
    public function getExperiences()
    {
        return $this->experiences;
    }

    /**
     * @param mixed $experiences
     */
    public function setExperiences($experiences)
    {
        $this->experiences = $experiences;
    }

    /**
     * @return mixed
     */
    public function getIsVerified()
    {
        return $this->isVerified;
    }

    /**
     * @param mixed $isVerified
     */
    public function setIsVerified($isVerified)
    {
        $this->isVerified = $isVerified;
    }
}
