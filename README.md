## A clean start.

Most applications have access control with access to privileged material.  This clean start comes with Devise for user authentication and CanCan and RoleModel for controlling access to privileged method calls and material.

Your development environment should take the following into consideration when using this repository.

1. [create GitHub account](https://github.com/signup/free), if does not yet exist
2. [send email](mailto:dave@reliacode.com) to request being added as collaborator to GitHub project
3. should also receive email invite for Heroku project and [create account](https://devcenter.heroku.com/articles/quickstart) when prompted to
4. verify existence of or [install heroku toolbelt](https://devcenter.heroku.com/articles/quickstart)
5. verify existence of or [install ruby 1.9.3](http://stackoverflow.com/questions/11436674/how-can-i-install-ruby-1-9-3-in-mac-os-x-mountain-lion-without-xcode#11436675) (Mac OSX, Mountain Lion)
6. verify existence of or [install bundler 1.2.1](https://github.com/carlhuda/bundler#installation-and-usage)
7. verify existence of or [install PostgreSQL](http://blog.willj.net/2011/05/31/setting-up-postgresql-for-ruby-on-rails-development-on-os-x/) (Mac OSX)

## Clone the GitHub repository:
Once your development environment is set up, you should be ready to work on dcvezzani/golden_monday.

    git clone git@github.com:dcvezzani/golden_monday.git
    cd golden_monday
    bundle install --binstubs

## Set up your PostgreSQL database.  
Replace 'dbprefix' with desired database prefix value.  This manually takes the place of ./bin/rake db:install.

    # log in as super user
    # [command line]
    psql -d postgres -U davidvezzani

    # create user and database
    # [psql prompt]
    create user dbprefix_admin with password 'admin!#13';
    CREATE DATABASE dbprefix_development OWNER dbprefix_admin;
    GRANT ALL ON DATABASE dbprefix_development TO dbprefix_admin; 

    # create test user and test database that can run with rspec tests
    # [psql prompt]
    CREATE USER rails with SUPERUSER CREATEDB password 'rails.admin!#13';
    CREATE DATABASE dbprefix_test OWNER rails;
    GRANT ALL ON DATABASE dbprefix_test TO rails; 

    # quite psql
    \q

### Create config/database.yml
While Heroku will create its own config/database.yml file during each deployment, you will need to set up your local development environment accordingly.

    # -e renders newlines (\n)
    # '!' escapes the history (!) character
    # [command line]
    echo -e "development:\n  adapter: postgresql\n  database: dbprefix_development\n  username: dbprefix_admin\n  password: admin"'!'"#13\n  encoding: utf8\n  pool: 5\n \ntest: \n  adapter: postgresql\n  database: dbprefix_test\n  username: rails\n  password: rails.pass13"'!'"#\n  encoding: utf8\n  pool: 5" > config/database.yml

    mkdir db/migrate
    bundle install --binstubs
    ./bin/rake db:migrate db:migrate:status

## Set up convenience shell scripts
Start your server and open the home page in your browser.

Usage: ./open.sh

    # open local web server home page in browser
    echo -e "open http://localhost:3696" > open.sh
    chmod 755 open.sh

Usage: ./start.sh

    # start the web server
    echo -e "#GMAIL_USERNAME=asdf GMAIL_PASSWORD=asdf RAILS_ENV=development bundle exec rails s -p 3696\nRAILS_ENV=development bundle exec rails s -p 3696" > start.sh
    chmod 755 start.sh


## Develop and test code
Repeat until ready to deploy

    git add .
    git commit -m "adds notes to indicate what work was done"
    git pull
    # resolve conflicts, if any, and commit again
    git push

### Deploy code to Heroku
Once your done writing and testing code, you are ready to deploy.

    # do this the first time to connect to the right Heroku repo
    # once this is executed, it should not be necessary to do it again
    git remote add heroku git@heroku.com:young-peak-9813.git

    git pull heroku master
    # resolve conflicts, if any, commit
    git push heroku master

    # synch up with github, if necessary

