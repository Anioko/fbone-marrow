#!/usr/bin/env python
import sys
import os

project = "{{cookiecutter.package_name}}"

BASE_DIR = os.path.join(os.path.dirname(__file__))

if BASE_DIR not in sys.path:
    sys.path.append(BASE_DIR)

# give wsgi the "application"
from {{cookiecutter.package_name}} import create_app
application = create_app()

# allow werkzeug to work with uWSGI
if application.debug:
    from werkzeug.debug import DebuggedApplication
    application.wsgi_app = DebuggedApplication(application.wsgi_app, True)

if __name__ == "__main__":
    application.run(host='0.0.0.0', debug=True)
