UI Demo using Backbone.js and CSS3 animations
=============================================

This is an application to demonstrate UI transitions using Backbone.js.
The following topics are covered in this application:

* User interface transitions using promises
* Push-state URL's and reopening the app
* Seeding the application in a certain state

Requirements
============

This code is written for ruby 1.9.3

External Deps
-------------

* sqlite-ruby ( http://sqlite-ruby.rubyforge.org/ ) for cache storage

Installation
============

```sh
git submodule init
git submodule update
bundle
bundle exec rake db:setup
```

License
=======

This project is licensed under the MIT license, a copy of which can be
found in the LICENSE file.

