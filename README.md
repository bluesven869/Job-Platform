Installation
------------

```
$ composer install 
```

Commands
--------

Insert into you crontab. This task will remove featured and published signs from expired jobs.

```
$ php bin/console job-platform:unpublish-unfeature-jobs
```

Doctrine
--------

```
$ php bin/console doctrine:database:drop --force
```

```
$ php bin/console doctrine:database:create
```

```
$ php bin/console doctrine:schema:update --force
```

```
$ php bin/console doctrine:query:sql "`cat database.sql`"
```

UserBundle
----------

```
$ php bin/console fos:user:create testuser test@example.com p@ssword
```

```
$ php bin/console fos:user:create sample@example.com --super-admin
```

Helpers
-------

```
$ php bin/console assets:install --symlink
```

```
$ fa
```

```
$ php bin/console assetic:dump --env prod
```

Translations
------------

```
$ php bin/console translation:update en FrontBundle --force --output-format=po --no-prefix # for 3.2
```

Code Validation
---------------

```
$ php-cs-fixer fix --level=symfony .
```
