# pdc_orcid
This application leverages ORCiD identifiers and ORCiD ID token services for researchers in the Princeton community.

[![CircleCI](https://circleci.com/gh/pulibrary/pdc_orcid/tree/main.svg?style=svg)](https://circleci.com/gh/pulibrary/pdc_orcid/tree/main)

## Dependencies
* Ruby: 3.2.0
* nodejs: 18.17.0
* yarn: 1.22.19
* Lando: 3.6.2

## Local development

### Setup
1. Check out code and `cd`
1. Install tool dependencies; If you've worked on other PUL projects they will already be installed.
    1. [Lando](https://docs.lando.dev/getting-started/installation.html)
    1. [asdf](https://asdf-vm.com/guide/getting-started.html#_2-download-asdf)
    1. postgres (`brew install postgresql`: Postgres runs inside a Docker container, managed by Lando, but the `pg` gem still needs a local Postgres library to install successfully.)
1. Install asdf dependencies with asdf
    1. `asdf plugin add ruby`
    1. `asdf plugin add node`
    1. `asdf plugin add yarn`
    1. `asdf install`
    1. ... but because asdf is not a dependency manager, if there are errors, you may need to install other dependencies. For example: `brew install gpg`
1. Or, if you are using `ruby-install` and `chruby` (instead of `asdf`):
   1. `ruby-install 3.2.0 -- --with-openssl-dir=$(brew --prefix openssl@1.1)`
   2. close the terminal window and open a new terminal
   3. `chruby 3.2.0`
   4. `ruby --version`
1. Install language-specific dependencies
    1. `bundle install`
    2. `yarn install`

### Starting / stopping services
We use lando to run services required for both test and development environments.

Start and initialize database services with:

`bundle exec rake servers:start`

To stop database services:

`bundle exec rake servers:stop` or `lando stop`

### Running tests
1. Fast: `bundle exec rspec spec`
2. Run in browser: `RUN_IN_BROWSER=true bundle exec rspec spec`

### Starting the development server
1. `bundle exec rails s -p 3000`
2. Access application at [http://localhost:3000/](http://localhost:3000/)

## Release and deployment

RDSS uses the same [release and deployment process](https://github.com/pulibrary/rdss-handbook/blob/main/release_process.md) for all projects.