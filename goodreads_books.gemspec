
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
#require "goodreads_books/version"
require_relative './lib/goodreads_books/version'

Gem::Specification.new do |spec|
  spec.name          = "goodreads-books"
  spec.version       = GoodreadsBooks::VERSION
  spec.authors       = ["Ni Chia"]
  spec.email         = ["nichia@gmail.com"]

  spec.summary       = %q{Goodreads Choice Awards Books}
  spec.description   = %q{Goodreads CLI gem is a command line application that lists the best books of Goodreads Choice Awards.}
  spec.homepage      = "https://github.com/nichia/goodreads_books.git"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  #if spec.respond_to?(:metadata)
  #  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  #else
  #  raise "RubyGems 2.0 or newer is required to protect against " \
  #    "public gem pushes."
  #end

  #spec.files         = `git ls-files -z`.split("\x0").reject do |f|
  #  f.match(%r{^(test|spec|features)/})
  #end

  spec.files         = [
    "lib/goodreads_books.rb",
    "lib/goodreads_books/version.rb",
    "lib/goodreads_books/cli.rb",
    "lib/goodreads_books/scraper.rb",
    "lib/goodreads_books/book.rb",
    "config/environment.rb"
  ]

  #spec.bindir        = "bin"
  #spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  #spec.require_paths = ["lib"]
  spec.executables << "goodreads-books"
  spec.require_paths = ["lib", "lib/goodreads_books"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0"
  spec.add_development_dependency "nokogiri", "~> 1.13.5"
  spec.add_development_dependency "colorize", "~> 0"
end
