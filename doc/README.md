# Hymir

Hymir is a small blogging application using the
[Mongo database](http://www.mongodb.org).

## Installation

Assuming you have Rails already installed, all what's left is MongoDB
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

Simply start your mongo daemon and run `script/server`.
