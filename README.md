# Simply-Order Rails API

This a Ruby on Rails back-end API with PostgreSQL. The goal of this API is to provide an app to take an easy order process to repalce call in order or SMS order.

# Software requirements

- Ruby 2.7.3
- Rails 6.1.4.4
- PostgreSQL

# Installations

Assume that you already have the above software lists installed.
After git clone from this repo.

`bundle install`

Edit `config/database.yml` , then change the username and password of PostgreSQL as per your system.

`rails db:create`

`rails db:migrate`

`rails db:seed`

`rails s`
