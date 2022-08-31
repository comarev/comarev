# Comarev-API

![rspec workflow](https://github.com/belgamo/comarev/actions/workflows/rspec.yml/badge.svg)
![rubocop workflow](https://github.com/belgamo/comarev/actions/workflows/rubocop.yml/badge.svg)

<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-18-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

This application is a partner management system. Basically, the Comarev admins register the interested companies that want to give a discount on their products/services to the Comarev contributors who are also registered in the system. Then, when the contributor buys something at the company (Comarev partner), they just have to scan a QR Code emitted in our dashboard and the system will return if they are ok with the payment (contribution), or not. If so, the contributor can get a discount.

Please check the [WHO_WE_ARE](WHO_WE_ARE.md) section for more information.

## Welcome Contributors!

Please feel free to contribute! While we welcome all contributions to this app, pull-requests that address outstanding Issues and have appropriate test coverage for them will be strongly prioritized.

Please check the [Contributing](CONTRIBUTING.md) section for more information.

## Roadmap

Check [our board](https://github.com/comarev/comarev/projects/1) for more details about what we're building.

- [x] Comarev API MVP

The core of this system is ready and running on production. But there are lot of improvements we can do and we need your help!

## Development

### Getting started

Clone the project from Github:

    git clone git@github.com:comarev/comarev.git && cd comarev

Install dependencies:

    bundle install

Create a **.env** file by copying the existing one:

    cp .env.example .env

Go to the .env file and set this:

```
PG_HOST=<your_database_host>
PG_USERNAME=<your_database_username>
PG_PASSWORD=<your_database_password>
```

Prepare database.yml:

    cp config/database.example.yml config/database.yml

Create the database:

    bundle exec rails db:create

Run migrations:

    bundle exec rails db:migrate

Run database seeds:
  ```bash
    # to populate with some users

    bundle exec rails db:seed
  ```


Run the server:

    bundle exec rails s

Run tests:

    bundle exec rspec

After running the server, you can also preview the emails at http://localhost:3000/rails/mailers.

### Setup with docker

You will need to install [docker-compose](https://docs.docker.com/compose/install/)

Prepare database.yml & .env

    cp config/database.example.yml config/database.yml && cp .env.example .env

Build the app image

    docker-compose build

Database setup:

    docker-compose run --rm api rails db:setup

Start the containers:

    docker-compose up

Them you should have the comarev-api running on `localhost:3000`

There will be this users to login:

admin: `admin@example.com`
regular: `regular@example.com`

with password: `123456`, for both

To stop the containers run:

    docker-compose down

## Usage
For information concerning API usage and endpoints examples, please check the [Usage](USAGE.md) section.

## Application Concepts

### Users

A user can be an `admin`, `manager`, `emplyoee` or a `customer`.

- Admins are the Comarev employees and can constrol the entire system. They are able to create the other kind of users. To become an admin, the user need the `admin` attibute `true`.
- Managers are the company managers. They can emmit their QR Code and also check if a user is able to get discount. To become a manager, the user needs to be assigned to a company.
- Employees do the same as managers, but they can't invite other employees or manage the company config.
- Customers are the Comarev contributors. They are supposed to pay invoices and get discounts. If the user is neither an admin nor a manager, he's a customer.

### Companies

A company is a comarev partner. They offer discounts to the Comarev contributors.

### Invoices

A invoice is created for a user. When all invoices are paid, the user is able to get a discount. Invoices can only be created and mark as paid by an admin user, but customers can visualize them.

## Found this project interesting?

If you found this project useful, then please consider leaving a :star: on Github, thanks :D

## Contributors ✨

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/m-pereira"><img src="https://avatars.githubusercontent.com/u/47258878?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Mauricio Lima</b></sub></a><br /><a href="https://github.com/comarev/comarev/commits?author=m-pereira" title="Code">💻</a> <a href="https://github.com/comarev/comarev/commits?author=m-pereira" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/belgamo"><img src="https://avatars.githubusercontent.com/u/19699724?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Gabriel Belgamo</b></sub></a><br /><a href="https://github.com/comarev/comarev/commits?author=belgamo" title="Code">💻</a> <a href="https://github.com/comarev/comarev/commits?author=belgamo" title="Documentation">📖</a></td>
    <td align="center"><a href="https://www.linkedin.com/in/brunoviveiros/"><img src="https://avatars.githubusercontent.com/u/27422266?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Bruno Viveiros</b></sub></a><br /><a href="https://github.com/comarev/comarev/commits?author=BrunoViveiros" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/RenanRSilva"><img src="https://avatars.githubusercontent.com/u/77541655?v=4?s=100" width="100px;" alt=""/><br /><sub><b>RenanRambul</b></sub></a><br /><a href="https://github.com/comarev/comarev/commits?author=RenanRSilva" title="Code">💻</a></td>
    <td align="center"><a href="http://linkedin.com/in/thiago-antonello-vargas-241a77180/"><img src="https://avatars.githubusercontent.com/u/72185566?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Thiago Antonello Vargas</b></sub></a><br /><a href="https://github.com/comarev/comarev/commits?author=thiantonello" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/ivopozzani"><img src="https://avatars.githubusercontent.com/u/84991192?v=4?s=100" width="100px;" alt=""/><br /><sub><b>ivopozzani</b></sub></a><br /><a href="https://github.com/comarev/comarev/commits?author=ivopozzani" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/tonyaraujop"><img src="https://avatars.githubusercontent.com/u/92229784?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Antônio Paulino</b></sub></a><br /><a href="https://github.com/comarev/comarev/commits?author=tonyaraujop" title="Code">💻</a></td>
  </tr>
  <tr>
    <td align="center"><a href="https://www.linkedin.com/in/perchespierri/"><img src="https://avatars.githubusercontent.com/u/81635560?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Rafael Perches Pierri</b></sub></a><br /><a href="https://github.com/comarev/comarev/commits?author=perchespierri" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/mathewt-p"><img src="https://avatars.githubusercontent.com/u/79904624?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Mathew Thomas</b></sub></a><br /><a href="https://github.com/comarev/comarev/commits?author=mathewt-p" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/rhian-cs"><img src="https://avatars.githubusercontent.com/u/72531802?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Rhian</b></sub></a><br /><a href="https://github.com/comarev/comarev/commits?author=rhian-cs" title="Code">💻</a></td>
    <td align="center"><a href="http://www.wenderfreese.com"><img src="https://avatars.githubusercontent.com/u/941776?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Wender Freese</b></sub></a><br /><a href="https://github.com/comarev/comarev/pulls?q=is%3Apr+reviewed-by%3Awenderjean" title="Reviewed Pull Requests">👀</a></td>
    <td align="center"><a href="http://rodrigo.vitiello.com.br"><img src="https://avatars.githubusercontent.com/u/12713965?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Rodrigo Vitiello</b></sub></a><br /><a href="https://github.com/comarev/comarev/pulls?q=is%3Apr+reviewed-by%3ARodrigoVitiello" title="Reviewed Pull Requests">👀</a></td>
    <td align="center"><a href="https://github.com/andreLumor"><img src="https://avatars.githubusercontent.com/u/36737050?v=4?s=100" width="100px;" alt=""/><br /><sub><b>André Moreira</b></sub></a><br /><a href="https://github.com/comarev/comarev/commits?author=andreLumor" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/Thekote"><img src="https://avatars.githubusercontent.com/u/45775182?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Guilherme Monteiro</b></sub></a><br /><a href="https://github.com/comarev/comarev/commits?author=Thekote" title="Code">💻</a></td>
  </tr>
  <tr>
    <td align="center"><a href="https://codesilva.github.io"><img src="https://avatars.githubusercontent.com/u/15680379?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Edigleysson Silva</b></sub></a><br /><a href="https://github.com/comarev/comarev/pulls?q=is%3Apr+reviewed-by%3Ageeksilva97" title="Reviewed Pull Requests">👀</a></td>
    <td align="center"><a href="https://github.com/HeitorMC"><img src="https://avatars.githubusercontent.com/u/34009891?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Heitor de Melo </b></sub></a><br /><a href="https://github.com/comarev/comarev/commits?author=HeitorMC" title="Code">💻</a></td>
    <td align="center"><a href="https://www.linkedin.com/in/antonio-simei/"><img src="https://avatars.githubusercontent.com/u/79973491?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Antônio Simei</b></sub></a><br /><a href="https://github.com/comarev/comarev/commits?author=aq-simei" title="Code">💻</a></td>
    <td align="center"><a href="https://www.linkedin.com/in/eric-poloni-ara%C3%BAjo-7aa466182/"><img src="https://avatars.githubusercontent.com/u/103846371?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Eric Poloni Araujo</b></sub></a><br /><a href="https://github.com/comarev/comarev/commits?author=ericaraujo13" title="Code">💻</a> <a href="https://github.com/comarev/comarev/pulls?q=is%3Apr+reviewed-by%3Aericaraujo13" title="Reviewed Pull Requests">👀</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
