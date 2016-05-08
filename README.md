# Jekyll Authors Plugin

A Jekyll plugin that manages all the author data from `_config.yml` and `_data/authors.*`

[![Build Status](https://travis-ci.org/GarthDB/jekyll-authors.svg)](https://travis-ci.org/GarthDB/jekyll-authors)

# Author information

A list of authors can be declared in `_config.yml` as an array in `authors` and/or in a [Jekyll data file](https://jekyllrb.com/docs/datafiles/) (ie `_data/authors.yml` or `_data/authors.json`).

*Note:* if an author slug is used in both lists (like `benbalter` in the examples below) it will keep the information from the `_config.yml` file and reject the `_data/authors.*` author data with the same slug.

Example `_config.yml`:

```yml
timezone: UTC

authors:
  garthdb:
    name: Garth Braithwaite
    uri: http://garthdb.com/
    email: garthdb@adobe.com
    twitter: garthdb
  benbalter:
    name: Ben Balter
    uri: http://ben.balter.com/
    email: ben.balter@github.com
    twitter: benbalter
```

Example `_data/authors.yml`:

```yml
pathawks:
  name: Pat Hawks
  uri: https://pathawks.com
  email: pat@pathawks.com
  twitter: pathawks
benbalter:
  name: The Ben Balter
  uri: http://ben.balter.com/
  email: ben.balter@github.com
  twitter: benbalter
```

The author information can then be referenced in a post by using the author slug.

For example if a post had the front matter:

```yml
---
title: "Super Great Post Title"
author: "benbalter"
---
```

The layout could use the author information from list:

```liquid
{% if page.author.name and page.author.uri %}
  <a href="{{ page.author.uri }}">{{ page.author.name }}</a>
{% else %}
  {{ page.author }}
{% endif %}
```

It is recommended to check if properties needed are available and to fallback to the author if they are not.
