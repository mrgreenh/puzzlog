# Puzzlog
This project aims to define and prototype a new class of content creation online services.
To learn how to use it, install it locally or use your invitation to the [online] alpha testing program.

## Local Installation
To install Puzzlog locally, you first need to install Ruby on your computer. I suggest using [RVM] if you work on a Unix system, use [RailsInstaller] to install both Ruby and Rails on a Windows machine (more on Rails' version later).
Please pay attention: 
* This application has been tested with Ruby 1.9.3.
* It it strongly recommended to use Rails 3.2.1.

Install PostgreSQL (Puzzlog has been developed with version 9.1.3) and create a production database and a user with full privileges on it as described below (if you whish to use Puzzlog as-is):
* Database name: "fragments_project"
* Username: "postgres"
* Password: "postgres"
If you want, you can modify these parameters in config/database.yml

Install [ImageMagick]:
If you are on a mac and you use MacPorts it's as easy as:
```
sudo port install ImageMagick
```

Now you are ready to go, you only miss the code:
	git clone https://github.com/mrgreenh/puzzlog.git

Open a terminal window and reach the project folder, then type:
```
bundle install
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
rails s
```

Open a browser window and navigate to
	http://localhost:3000
	
Don't hesistate to contact me if either this installation guide doesn't work for you, or you would like to fork/try puzzlog, or any other problem.

Have fun!

##License
This CMS is distributed under the GPLv2 License

[online]: http://puzzlog.herokuapp.com
[RVM]: https://rvm.io/rvm/install/
[RailsInstaller]: http://railsinstaller.org
[ImageMagick]: http://www.imagemagick.org/script/binary-releases.php#macosx