Furlandia 2017 Website
======================

Site is static and built using [Middleman](https://middlemanapp.com/). Technologies used are:

* Templates - [Haml](http://haml.info/)
* CSS uses [Sass](http://sass-lang.com/) and [Bootstrap](http://getbootstrap.com/)
* Javascript uses [qQuery](http://jquery.com/)
* Text is in [Markdown](http://daringfireball.net/projects/markdown/)
* Data is in [Yaml](http://www.yaml.org/spec/1.2/spec.html)
* Logic is in [Ruby](https://www.ruby-lang.org/en/)

Please familiarize yourself with these if you wish to contribute.
We don't have explicit style guides but please follow existing conventions in the repository.

Development
-----------

Code has been tested to run on Debian based systems.
It's recommended that you do development in a VM if you don't have a Unix environment available.
The following should get you up and running on Debian or Ubuntu.
Feel free to substitute the package manager of your choice.

~~~bash
sudo apt-get install ruby ruby-dev nodejs
sudo gem install bundler rake
bundle install
rake server
~~~

Once the server has started, open [http://localhost:4567/](http://localhost:4567/) to view the development site.
The page should automatically refresh whenever any changes are saved.
