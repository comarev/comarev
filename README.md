# Comarev-API

![rspec workflow](https://github.com/belgamo/comarev/actions/workflows/rspec.yml/badge.svg)
![rubocop workflow](https://github.com/belgamo/comarev/actions/workflows/rubocop.yml/badge.svg)

COMAREV is a therapy community that offers voluntary and transitory care for people with problems arising from the use and/or dependence of psychoactive substances.

## Description

The project's idea is to create the MVP of a system that allows Comarev's managers to manage the entity's contributors and partners, whose objective is to raise funds. The entity will look for stores and businesses for discounts for monthly contributors. The contributor will have access to an app and if they are up to date with the contribution, they can get discounted purchases from partners committed to a QR CODE through an app.

## Requirements:

- Ruby 2.7.0
- Rails 6.0.3.6
- PostgreSQL 12.2

## 🚀 Setup

1- Clone the repo to your local:

    $ git clone git@github.com:comarev/comarev.git && cd comarev

2- Install dependencies:

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

### Setup with docker

You will need to install [docker-compose](https://docs.docker.com/compose/install/)

1- Prepare database.yml & .env

    $ cp config/database.example.yml config/database.yml && cp .env.example .env

2- Build the app image

    $ docker-compose build

3- Database setup:

    $ docker-compose run --rm api rails db:setup

4- Start the containers:

    $ docker-compose up

Them you should have the comarev-api running on `localhost:3000`

There will be this users to login:

admin: `admin@example.com`
regular: `regular@example.com`

with password: `123456`, for both

To stop the containers run:

    $ docker-compose down

## Run tests

    $ bundle exec rspec
