
require_relative "./lib/berklee_valencia/version.rb"

Gem::Specification.new do |s|
  s.name        = 'berklee-valencia'
  s.version     = BerkleeValencia::VERSION
  s.date        = '2018-04-01'
  s.summary     = "CLI gem for user to read latest Berklee Valencia news and about programs offered."
  s.description = "Hello! Berklee Valencia is Berklee College of Music's graduate campus located in Valencia, Spain.
  Filled with the musicians, business moguls and technologists of today and tomorrow, there is a wealth of things to discover here."
  s.authors     = ["Gingertonic"]
  s.email       = 'bethmschofield@gmail.com'
  s.files       = ["lib/berklee_valencia/version.rb", "lib/berklee_valencia.rb", "lib/berklee_valencia/cli.rb", "lib/berklee_valencia/article.rb", "lib/berklee_valencia/program.rb", "lib/berklee_valencia/scraper.rb", "lib/berklee_valencia/formatter.rb", "lib/berklee_valencia/printer.rb", "lib/berklee_valencia/item.rb", "lib/berklee_valencia/category.rb", "config/environment.rb"]
  s.homepage    = 'https://github.com/Gingertonic/berklee-valencia'
  s.license     = 'MIT'
  s.executables << 'berklee-valencia'

  s.add_development_dependency "bundler", "~> 1.16"
  s.add_development_dependency "rake", "~> 12.3"
  s.add_development_dependency "rspec", ">= 3.0"
  s.add_development_dependency "pry", ">= 0"

  s.add_dependency "nokogiri", ">= 1.8"
  s.add_dependency "open_uri_redirections"

end
