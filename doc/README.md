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
Last but not least, you can change the site's title and some other
things in `config/hymir.yml`.

Now simply start your mongo daemon and run `script/server`.
