# Twissandra.rb

Rebuilding Twitter with Ruby and Cassandra

## Genesis

This project owes its existence to the [Twissandra](https://github.com/twissandra/twissandra) project. The schema and naming of entities are largely derived from Twissandra, but the implementation is my own.

## Installation

Install and start cassandra

    $ brew install cassandra
    $ cassandra -f

Install and bundle ruby

    $ rvm install jruby
    $ rvm use jruby
    $ bundle install

Load in the schema

    $ cqlsh < schema.sql

## TODO

* Uniqueness for usernames
* Show a public timeline
* Pagination
* Prepared statements

## Contributing

1. Fork it ( http://github.com/matthewrudy/twissandra-rb/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
