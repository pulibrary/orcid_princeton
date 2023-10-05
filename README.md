# pdc_orcid
To support researchers and leverage ORCiD identifiers for research data in the Princeton community

## Dependencies
* Ruby: 3.2.0
* nodejs: 18.17.0
* yarn: 1.22.19
* Lando: 3.6.2

## Local development

### Setup

### Starting / stopping services
We use lando to run services required for both test and development environments.

Start and initialize database services with:

`bundle exec rake servers:start`

To stop database services:

`bundle exec rake servers:stop` or `lando stop`

