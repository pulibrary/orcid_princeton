# ORCID@Princeton
This application leverages ORCID services and ORCID iDs for researchers in the Princeton community.

[![CircleCI](https://circleci.com/gh/pulibrary/orcid_princeton/tree/main.svg?style=svg)](https://circleci.com/gh/pulibrary/orcid_princeton/tree/main)

[![Coverage Status](https://coveralls.io/repos/github/pulibrary/orcid_princeton/badge.svg?branch=main)](https://coveralls.io/github/pulibrary/orcid_princeton?branch=main)

## Dependencies
* Ruby: 3.2.0
* nodejs: 18.17.0
* yarn: 1.22.19
* Lando: 3.6.2

## Updating the banner

Update the file `config/banner.yml`. Note that each environment can have its own banner text.

## Creating an ORCID sandbox account

  1. A Mailinator account is required for you to be able to verify your ORCID account. "Setup" your Mailinator your email:
     1. visit https://www.mailinator.com/v4/public/inboxes.jsp
     1. put a fake email address (e.g., myname) into the search box at the top of the page.
        * your email wil include `@mailinator.com` (e.g. `myname@mailinator.com`) even though you do not need to put `@mailinator.com` in the search box
     1. Click go and you will be taken to the "inbox" for that email.
  1. Use the mailinator email address (e.g. `myname@mailinator.com`) to register an account at https://sandbox.orcid.org/register
  1. Record your login and password in a password manager so you can find them again.
  1. Now in mailinator respond to the verification email.
     * If you do not see your email make sure the search box has your email.  You do not need to include `mailinator.com`
     * Click the verify button in the email
  1. Your account should now be verified in the OCRID Sandbox

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
1. `bundle exec foreman start`
2. Access application at [http://localhost:3000/](http://localhost:3000/)

### ORCID Environment variables
You need to have the following variables in your environment to connect with the ORCID sandbox.  Actual values are in lastpass under "ORCID Local API key".
export ORCID_CLIENT_ID="xxx"
export ORCID_CLIENT_SECRET="xxx"

## Release and deployment

RDSS uses the same [release and deployment process](https://github.com/pulibrary/rdss-handbook/blob/main/release_process.md) for all projects.

## ORCID Branding

In compliance with ORCID's [general brand guidance](https://info.orcid.org/brand-guidelines/#h-general-brand-guidance) around capitalization of the ORCID organization name and ORCID identifier information, we use the following written style to refer to ORCID and ORCID identifiers:

* **ORCID** - (noun) the ORCID organization; (adjective) part of a noun phrase that refers to things that are about ORCID, but not by the organization itself
  * Noun example: "ORCID is a global, not-for-profit organization."
  * Adjective example: "Click here to view your ORCID record"
* **ORCID identifer** or **ORCID iD** (abbreviation) - unique identifer offered by the ORCID organization
