fbone-marrow cookiecutter template
========================================

This is a [CookieCutter](http://pydanny.com/cookie-project-templates-made-easy.html) template for generating a bare bones Flask project based off of [fbone](https://github.com/imwilsonxu/fbone) within a [Vagrant](https://www.vagrantup.com) development environment. It provides simple starting points for using some of the popular best-practices and features:

  * Proper [setuptools](https://pypi.python.org/pypi/setuptools) compatible package layout.
  * Several of nearly-standard extensions ([Flask-SQLAlchemy](http://flask-sqlalchemy.pocoo.org/2.1/), [Flask-WTF](https://flask-wtf.readthedocs.org/en/latest/), [Flask-Cache](https://pythonhosted.org/Flask-Cache/), [Flask-Script](https://flask-script.readthedocs.org/en/latest/))
  * [Flask-Testing](https://pythonhosted.org/Flask-Testing/) and [Twill](http://twill.idyll.org/) based tests.
  * Vagrant development environment to provision [Nginx](https://www.nginx.com) and [uWSGI](https://uwsgi-docs.readthedocs.org/en/latest/) properly and seamlessly.
  * [Bower](http://bower.io) for frontend package management

Required Libraries
------------------

  * Cookiecutter
  * Virtualbox
  * Vagrant

Installation
------------

Before you can use this template you should install ``cookiecutter`` via ``easy_install`` or ``pip``:

    $ pip install cookiecutter

The ``cookiecutter`` executable should appear in your Python's ``bin/`` (in Windows ``Scripts/``) directory. You might need to add that directory to your ``PATH`` to run the executable. You should also have ``git`` installed in your system.

Usage
-----

To initialize a new project, ensure that ``cookiecutter`` is in your path and run:

     $ cookiecutter gh:cmeadows/fbone-marrow.git

To provision your development environment:

    $ cd <your-package-name>/
    $ vagrant up

You may now visit http://localhost:8931 to view your fbone-marrow Application. Now, you are all set to start developing.

See also
--------
  * Alternative flask templates:
      * https://github.com/sloria/cookiecutter-flask
      * https://github.com/zachwill/flask_heroku
      * https://github.com/berlotto/flask-app-template
      * https://github.com/kamalgill/flask-appengine-template
  * Buildout project boilerplate template: https://github.com/konstantint/cookiecutter-python-boilerplate
  * Blog post: http://fouryears.eu/2015/04/21/a-flask-project-template/

Copyright & License
-------------------

  * Copyright 2016, Collin Meadows
  * License: MIT
