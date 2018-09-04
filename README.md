# GoodreadsBooks

Welcome to GoodreadsBooks CLI gem! This is a command line application that lists books that are Winners of Goodreads Choice Awards. By default, the app will list the most recent choice awards winning books for each book category from Goodreads web page https://www.goodreads.com/choiceawards.

Users then have the option to:
  1) select a different Choice Awards year (awards year are from 2010 until the most recent year, which is usually the previous calendar year)
  2) get a detail view of the awards winning book
  3) open up the book information page on Goodreads.com website

## Installation

    $ gem install goodreads-books

## Usage

Type the below command and follow the prompts.

    $ goodreads-books


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nichia/goodreads_books. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the GoodreadsBooks project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/nichia/goodreads_books/blob/master/CODE_OF_CONDUCT.md).
