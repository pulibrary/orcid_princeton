# 2. Custom FAQ events in Plausible

Date: 2024-08-08

## Status

Accepted

## Context

We need to keep track of the amount of times that any user clicks on and expands a Frequently Asked Question (FAQ) in ORCID@Princeton.

## Decision

The clicks are tracked by a custom event in Plausible, with a custom property that is defined to correlate to the wording of the question, but not be the question itself.

The mapping of Plausible property to question is as follows:

|Plausible Event Property|Frequently Asked Question|
|-|-|
|orcid|What is ORCID?|
|no_orcid|What if I don’t have an ORCID iD?|
|multi_id|What do I do if I have more than one ORCID iD?|
|trusted_org|What is a "Trusted Organization"?|
|princeton_conversion|Why does the University want me to connect my ORCID iD to Princeton?|
|disconnect_id|Can I disconnect my ORCID iD from Princeton, or from any other organization?|
|SciENv|What is the relationship between ORCID and SciENcv?|
|cv|What is the relationship between ORCID and my CV?|
|fed_agencies|Are Federal Agencies requiring ORCID?|

## Consequences

By using custom properties as a key/value store for the questions, the wording of the questions themselves can be changed slightly over time while remaining the same root question and answer from an analytics collection standpoint.  However, the above table will may need to be consulted periodically, and will need to be kept updated if/when question wording is changed, or questions are added.
