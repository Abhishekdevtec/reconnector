# README

This README would normally document whatever steps are necessary to get the
application up and running.

# Ruby version
Ruby version 3.0.0 is required

# Rails version
Rails 7.0.x is required

# Server deployment
Deployed on Ubuntu 20.04

## Update the server
Run the following commands:

    sudo apt update
    sudo apt upgrade

## Create a new user for the application
Run the following commands:

    adduser rails
    adduser rails sudo

## Add SSH to the new user

On your local compute, run

    cat ~/.ssh/id_rsa.pub

On the remote server, run

    su - rails
    mkdir .ssh && chmod 700 .ssh && nano .ssh/authorized_keys

Paste your public key here and then save and exit the file with CTRL-X, then Y, the ENTER.

    chmod 600 .ssh/authorized_keys && exit

## Remove remote root login (Security)
As the root user, execute the following to open your ssh configuration file in your text editor:

    nano /etc/ssh/sshd_config

In this file, find the following line:

    PermitRootLogin yes

And change the yes, to no. Save and exit with CTRL + X, then Y, then ENTER.

Now, restart your SSH daemon with:

    service ssh restart

## Installing Ruby and application dependecies

Adding and installing node.js, yarn and redis

Node.js

    curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -

Yarn repository

    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

Redis

    sudo add-apt-repository ppa:chris-lea/redis-server

Refresh our packages list with the new repositories

    sudo apt-get update

Install our dependencies for compiiling Ruby along with Node.js and Yarn

    sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev dirmngr gnupg apt-transport-https ca-certificates redis-server redis-tools nodejs yarn

Installing Ruby via RBEnv

Run the following commands

    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
    echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
    git clone https://github.com/rbenv/rbenv-vars.git ~/.rbenv/plugins/rbenv-vars
    exec $SHELL
    rbenv install 3.0.2
    rbenv global 3.0.2

To update

    brew update && brew upgrade ruby-build
    cd "$(rbenv root)"/plugins/ruby-build && git pull

Disable installation of gem documentation

    nano ~/.gemrc

Add the following line

    gem: --no-document

Now install bundler by running

    gem install bundler

# Installing NGINX & Passenger

Run the following commands:

    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
    sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger focal main > /etc/apt/sources.list.d/passenger.list'
    sudo apt-get update
    sudo apt-get install -y nginx-extras libnginx-mod-http-passenger
    if [ ! -f /etc/nginx/modules-enabled/50-mod-http-passenger.conf ]; then sudo ln -s /usr/share/nginx/modules-available/mod-http-passenger.load /etc/nginx/modules-enabled/50-mod-http-passenger.conf ; fi
    sudo ls /etc/nginx/conf.d/mod-http-passenger.conf

we need to point Passenger to the correct version of Ruby.

    sudo nano /etc/nginx/conf.d/mod-http-passenger.conf

We simply want to change the passenger_ruby line to match the following:

    passenger_ruby /home/rails/.rbenv/shims/ruby;

restart Nginx

    sudo service nginx start

### Configure the web server

    sudo nano /etc/nginx/sites-available/default

Replace the contents of the file with the following code block. Be sure to replace the the highlighted parts with the appropriate username and application name (two locations):

    upstream app {
        # Path to Puma SOCK file, as defined previously
        server unix:/home/<rails_username>/<application_name>/shared/sockets/puma.sock fail_timeout=0;
    }

    server {
        listen 80;
        listen [::]:80;
        server_name reconnector.app;

        root /home/<rails_username>/<application_name>/public;

        try_files $uri/index.html $uri @app;

        location @app {
            proxy_pass http://app;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header Host $http_host;
            proxy_redirect off;
        }

        error_page 500 502 503 504 /500.html;
        client_max_body_size 4G;
        keepalive_timeout 10;
    }

Save and exit. This configures Nginx as a reverse proxy, so HTTP requests get forwarded to the Puma application server via a Unix socket. Feel free to make any changes as you see fit.

Restart Nginx to put the changes into effect:

    sudo service nginx restart

## Generate master and secret keys

To create a new config/master.key, delete config/master.key and config/credentials.yml.enc. Then run the following command to create a new key and encrypted credentials file:

    EDITOR="nano" bundle exec rails credentials:edit --environment production

## Setup the Ubuntu firewall

Type the following command and make sure you have OpenSSH and Nginix (Full, HTTP and HTTPS) options listed.

    sudo ufw app list

Allow OpenSSH and Nginx Full (HTTP and HTTPS) traffic

    sudo ufw allow OpenSSH && sudo ufw allow 'Nginx Full'

Enable the firewall by typing

    sudo ufw enable

## Enable Logrotate For Rails Production Logs

You might be surprised at just how easy to setup logrotate Rails logs is. The reason it is so handy is that a bunch of your operating system software is already using it. We just have to plug in our configuration and we’re set!

The first step is to open up /etc/logrotate.conf using vim or nano. Jump to the bottom of the file an add the following block of code. You’ll want to change the first line to match the location where your Rails app is deployed. Mine is under the deploy user’s home directory. Make sure to point to the log directory with the *.log bit on the end so that we rotate all the log files.

    /home/rails/APPNAME/log/*.log {
      daily
      missingok
      rotate 7
      compress
      delaycompress
      notifempty
      copytruncate
    }

## Setup Redis

Run the following command to setup the systemd service file

    sudo systemctl enable redis-server

Now, change the default configuration after installation.
To open the configuration file, use the text editor of your choice. In the example below, nano will be used.

    sudo nano /etc/redis/redis.conf

Uncomment *bind 127.0.0.1 ::1*
Change the *supervised no* to *supervised systemd*

Start the Redis service

    sudo systemctl restart redis.service

To verify that Redis is working, first check if it is running correctly via the command:

    sudo systemctl status redis

Check to see if Redis replies to a PING:

    redis-cli ping

## Setup sidekiq

Copy the sidekiq service file to the /etc/systemd/system directory

    sudo cp server_side/sidekiq.service /etc/systemd/system/sidekiq.service

To enable your service on every reboot

    sudo systemctl enable sidekiq.service

To verify that Sidekiq is working, first check if it is running correctly via the command:

    sudo systemctl status sidekiq

Controlling sidekiq

    systemctl stop sidekiq
    systemctl start sidekiq
    systemctl restart sidekiq
    systemctl kill -s TSTP sidekiq # quiet

# Log files

Here is a list of log files to help understand technical problems:

    sudo nano /var/log/nginx/error.log
    sudo nano /var/log/syslog
    nano /home/rails/APPNAME/log/*.log/production.log

To download the production log, run the following command:

    scp rails@reconnector.app:~/hippogriff_twenty_two/log/production.log ./production.log

# Importing Aquity V2 data

A Rails task exists and allows you to import Aquity V2 data exported as JSON from phpMyAdmin.

To import, drop the exported JSON file as **'input/aquity_v2/import.json'**

Run the Rails task using the following command:


    RAILS_ENV=production rails aquity_v2:import


The following commands are also available:


    RAILS_ENV=production rails aquity_v2:import_agents
    RAILS_ENV=production rails aquity_v2:import_contacts
    RAILS_ENV=production rails aquity_v2:import_districts
    RAILS_ENV=production rails aquity_v2:import_properties
    RAILS_ENV=production rails aquity_v2:import_property_images
    RAILS_ENV=production rails aquity_v2:import_person_property_requirements


# Importing GriffinProperty.com.au URL

A Rails task exists and allows you to import griffinproperty.com.au URLs for Aquity Properties.
The Aquity Properties must exist. The internal ID (Aquity V2 property ID) is used to find the
property.

The griffinproperty.com.au data must be exported as JSON from phpMyAdmin.

To import, drop the exported JSON file as **'input/griffin_property_com_au/import.json'**

Run the Rails task using the following command:


    RAILS_ENV=production rails griffinproperty_com_au:import



# Server maintenance

## Updating packages

Run the following commands to update Linux packages

    sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt clean -y && sudo apt autoclean -y

# Deploying an updated version of the site

Run the following command to pull a new version from Git and deploy

    cd ~/hippogriff_twenty_two && git stash && git pull && RAILS_ENV=production bundle install && RAILS_ENV=production bundle update --patch --strict && RAILS_ENV=production rails db:migrate log:clear assets:clean assets:precompile zeitwerk:check && sudo service nginx restart && sudo systemctl restart sidekiq

# Updating "Production" gems

## Updating bundler and gem

    gem update --system
    bundle update --bundler

## Updating gems

Split bundle update in 3 separate sub-steps, with increasing risk levels.

## Update gems to latest patch version

    bundle update --patch --strict

## Update gems to latest minor version

    bundle update --minor --strict

## Update gems to latest major version

    bundle update --major

# TODO

## WickedPdf Asset Precompilation fix

Replace the hard-coded CSS styles with:

    <%= wicked_pdf_stylesheet_link_tag "application" %>
    <%= wicked_pdf_stylesheet_link_tag "tailwind" %>
    <%= wicked_pdf_stylesheet_link_tag "inter" %>
    <%= wicked_pdf_stylesheet_link_tag "wkhtmltopdf" %>


## Resend Contects to Microsoft Graph

    Contact.where(synchronize_with_office_online: true).each do |c|
      if c.microsoft_graph_data && c.microsoft_graph_data.object_id.blank?
        ::AppServices::Microsoft::Graph::UpdateContact.new(c).update_contact
      end
    end

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

