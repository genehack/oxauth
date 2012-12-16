oxauth
======

Simple application demonstrating model based authentication/authorization in the OX web framework

To run this application:

* Install all required modules: `cpanm Dist::Zilla && dzil listdeps | cpanm`

* Start the application: `plackup app.psgi`

* Point a browser to http://localhost:5000/

* You can login as an admin user with 'admin@example.com' and
  'admin0987', or a regular user with 'user@example.com' and
  'user0987'. The former has access to the '/admin' endpoint; the
  latter does not.

