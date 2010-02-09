# Hymir

Hymir is a small blogging application using the
[Mongo database](http://www.mongodb.org).

## Installation

Assuming you have Rails already installed, all that's left is MongoDB
and some gems.  

You can download MongoDB [here](http://www.mongodb.org/display/DOCS/Downloads).  
As for the required gems, you can either run `rake gems:install` or
install them manually:

* haml
* mongo_mapper
* bcrypt-ruby
* formtastic
* rdiscount
* shoulda
* factory_girl

## Getting it up and running

Since Hymir uses Mongo there's no need to migrate the database schema or
anything the like.  
You'll probably want to seed your database with an
initial user though, so have a look in `db/seed.rb`, enter your user
details and run `rake db:seed`.  

Next up, you will want to rename the `production.example.rb` and `development.example.rb` files in `config/environments`.  
If you wish for the password reset mailer to work, you have to add your mailer settings in these files.

Last but not least, you can change the site's title and some other
things in `config/hymir.yml`.

Now simply start your mongo daemon and run `script/server`.

## Delayed Job

Hymir uses [Delayed Job](http://github.com/collectiveidea/delayed_job)
for its notification mailer. Please refer to its (Delayed Job's) 
documentation on how to run the worker.
