# Comarev-API
COMAREV is a therapy community that offers voluntary and transitory care for people with problems arising from the use and/or dependence of psychoactive substances.

![rspec workflow](https://github.com/belgamo/comarev/actions/workflows/rspec.yml/badge.svg)
![rubocop workflow](https://github.com/belgamo/comarev/actions/workflows/rubocop.yml/badge.svg)

##  Description
The project's idea is to create the MVP of a system that allows Comarev's managers to manage the entity's contributors and partners, whose objective is to raise funds. The entity will look for stores and businesses for discounts for monthly contributors. The contributor will have access to an app and if they are up to date with the contribution, they can get discounted purchases from partners committed to a QR CODE through an app.

## Requirements:

* Ruby 2.7.0
* Rails
* PostgreSQL

## 🚀  Setup
1- Clone the repo to your local:

    $ git clone git@github.com:comarev/comarev.git && cd comarev

2-  Install dependencies:

    $ bundle install

3- Prepare database.yml

    $ cp config/database.example.yml config/database.yml

4- Go to the database.yml file and fill in your postgreSQL data

    host: '<your host>'
    username: '<your PostgreSQL username>'
    password: '<your PostgreSQL password>'

5- Create the database for the current environment

    $ rails db:create

6- Run migrations for the current environment.

    $ rails db:migrate

7 - Run the server

    $ rails s

## Run tests

    $ bundle exec rspec
