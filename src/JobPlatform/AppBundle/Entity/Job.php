<?php

namespace JobPlatform\AppBundle\Entity;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Intl\Intl;

/**
 * @ORM\Entity(repositoryClass="JobPlatform\AppBundle\Repository\JobRepository")
 * @ORM\Table(name="job_platform_jobs")
 * @ORM\HasLifecycleCallbacks()
 */
class Job
{
    /**
     * @ORM\Id
     * @ORM\Column(type="integer")
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    protected $id;

    /**
     * @ORM\ManyToOne(targetEntity="User", inversedBy="jobs")
     * @ORM\JoinColumn(name="user_id", referencedColumnName="id")
     */
    private $user;

    /**
     * @ORM\ManyToOne(targetEntity="Company", inversedBy="jobs")
     * @ORM\JoinColumn(name="company_id", referencedColumnName="id", onDelete="cascade")
     */
    private $company;

    /**
     * @ORM\ManyToOne(targetEntity="Contract", inversedBy="jobs")
     * @ORM\JoinColumn(name="contract_id", referencedColumnName="id")
     */
    private $contract;

    /**
     * @ORM\ManyToOne(targetEntity="ProjectType", inversedBy="jobs")
     * @ORM\JoinColumn(name="project_type_id", referencedColumnName="id")
     */
    private $projectType;

    /**
     * @ORM\ManyToMany(targetEntity="Category", inversedBy="jobs")
     * @ORM\JoinTable(name="job_platform_job_category")
     */
    private $categories;

    /**
     * @ORM\OneToMany(targetEntity="Favorite", mappedBy="job")
     */
    private $favorites;

    /**
     * @ORM\Column(type="string", length=100)
     */
    private $name;

    /**
     * @ORM\Column(type="text")
     */
    private $description;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $country;

    /**
     * @ORM\Column(type="decimal", precision=7, scale=2, nullable=true)
     */
    private $price;


    /**
     * @ORM\Column(type="boolean", nullable=true, name="is_featured")
     */
    private $isFeatured;

    /**
     * @ORM\Column(type="datetime", nullable=true, name="featured_until")
     */
    private $featuredUntil;

    /**
     * @ORM\Column(type="boolean", nullable=true, name="is_published")
     */
    private $isPublished;

    /**
     * @ORM\Column(type="datetime", nullable=true, name="published_until")
     */
    private $publishedUntil;

    /**
     * @ORM\Column(name="created", type="datetime")
     */
    private $created;

    /**
     * @ORM\Column(name="modified", type="datetime", nullable=true)
     */
    private $modified;

    public function __construct()
    {
        $this->favorites = new ArrayCollection();
    }

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
    public function getContract()
    {
        return $this->contract;
    }

    /**
     * @param mixed $contract
     */
    public function setContract($contract)
    {
        $this->contract = $contract;
    }

    /**
     * @return mixed
     */
    public function getCompany()
    {
        return $this->company;
    }

    /**
     * @param mixed $company
     */
    public function setCompany($company)
    {
        $this->company = $company;
    }

    /**
     * @return mixed
     */
    public function getCategories()
    {
        return $this->categories;
    }

    /**
     * @param mixed $categories
     */
    public function setCategories($categories)
    {
        $this->categories = $categories;
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
    public function getCountry()
    {
        return $this->country;
    }

    public function getCountryName()
    {
        return Intl::getRegionBundle()->getCountryName($this->getCountry());
    }

    /**
     * @param mixed $country
     */
    public function setCountry($country)
    {
        $this->country = $country;
    }

    /**
     * @return mixed
     */
    public function getPrice()
    {
        return $this->price;
    }

    /**
     * @param mixed $price
     */
    public function setPrice($price)
    {
        $this->price = $price;
    }

    /**
     * @return mixed
     */
    public function getCreated()
    {
        return $this->created;
    }

    /**
     * @param mixed $created
     */
    public function setCreated($created)
    {
        $this->created = $created;
    }

    public function isFavoriteByUser($user)
    {
        if ($user) {
            foreach ($this->favorites as $favorite) {
                if ($favorite->getUser() == $user) {
                    return true;
                }
            }
        }

        return false;
    }

    public function isAppliedByUser($user)
    {
        return true;
    }

    /**
     * @return mixed
     */
    public function getProjectType()
    {
        return $this->projectType;
    }

    /**
     * @param mixed $projectType
     */
    public function setProjectType($projectType)
    {
        $this->projectType = $projectType;
    }

    /**
     * @return mixed
     */
    public function getFavorites()
    {
        return $this->favorites;
    }

    /**
     * @param mixed $favorites
     */
    public function setFavorites($favorites)
    {
        $this->favorites = $favorites;
    }

    /**
     * @return mixed
     */
    public function getIsFeatured()
    {
        return $this->isFeatured;
    }

    /**
     * @param mixed $isFeatured
     */
    public function setIsFeatured($isFeatured)
    {
        $this->isFeatured = $isFeatured;
    }

    /**
     * @return mixed
     */
    public function getFeaturedUntil()
    {
        return $this->featuredUntil;
    }

    /**
     * @param mixed $featuredUntil
     */
    public function setFeaturedUntil($featuredUntil)
    {
        $this->featuredUntil = $featuredUntil;
    }

    /**
     * @return mixed
     */
    public function getIsPublished()
    {
        return $this->isPublished;
    }

    /**
     * @param mixed $isPublished
     */
    public function setIsPublished($isPublished)
    {
        $this->isPublished = $isPublished;
    }

    /**
     * @return mixed
     */
    public function getPublishedUntil()
    {
        return $this->publishedUntil;
    }

    /**
     * @param mixed $publishedUntil
     */
    public function setPublishedUntil($publishedUntil)
    {
        $this->publishedUntil = $publishedUntil;
    }

    /**
     * @return mixed
     */
    public function getModified()
    {
        return $this->modified;
    }

    /**
     * @param mixed $modified
     */
    public function setModified($modified)
    {
        $this->modified = $modified;
    }
}
