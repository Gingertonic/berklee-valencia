#
# lib = File.expand_path("../lib", __FILE__)
# $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "./lib/berklee_valencia/version"

Gem::Specification.new do |s|
  s.name        = 'berklee_valencia'
  s.version     = BerkleeValencia::VERSION
  s.date        = '2018-04-01'
  s.summary     = "CLI gem for user to read latest Berklee Valencia news and about programs offered."
  s.description = "Hello! Berklee Valencia is Berklee College of Music's graduate campus located in Valencia, Spain.
  Filled with the musicians, business moguls and technologists of today and tomorrow, there is a wealth of things to discover here."
  s.authors     = ["Gingertonic"]
  s.email       = 'bethmschofield@gmail.com'
  s.files       = [
                  "lib/berklee_valencia.rb",
                  "lib/berklee_valencia/cli.rb", "lib/berklee_valencia/scraper.rb",
                  "lib/berklee_valencia/formatter.rb", "lib/berklee_valencia/printer.rb",
                  "lib/berklee_valencia/news_article.rb", "lib/berklee_valencia/program.rb"
                  ]
  s.homepage    = 'http://rubygems.org/gems/worlds-best-restaurants'
  s.license     = 'MIT'
  s.executables << 'berklee_valencia'

  s.add_development_dependency "bundler", "~> 1.16"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "rspec", ">= 3.0"
  s.add_development_dependency "pry", ">= 0"

  s.add_dependency "nokogiri", ">= 1.8"
  s.add_dependency "open_uri_redirections"

end

# Gem::Specification.new do |spec|
#   spec.name          = "berklee_valencia"
#   spec.version       = BerkleeValencia::VERSION
#   spec.executables   << 'berklee_valencia'
#   spec.authors       = ["Gingertonic"]
#   spec.email         = ["bethmschofield@gmail.com"]
#
#   spec.summary       = "CLI gem for user to read latest Berklee Valencia news and about programs offered."
#   spec.description   = "Hello! Berklee Valencia is Berklee College of Music's graduate campus located in Valencia, Spain.
#   Filled with the musicians, business moguls and technologists of today and tomorrow, there is a wealth of things to discover here."
#   spec.homepage      = "https://github.com/Gingertonic/berklee-valencia"
#   spec.license       = "MIT"
#
#   # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
#   # to allow pushing to a single host or delete this section to allow pushing to any host.
#   if spec.respond_to?(:metadata)
#     spec.metadata["allowed_push_host"] = 'https://rubygems.org/'
#   else
#     raise "RubyGems 2.0 or newer is required to protect against " \
#       "public gem pushes."
#   end
#
#   spec.files         = `git ls-files -z`.split("\x0").reject do |f|
#     f.match(%r{^(test|spec|features)/})
#   end
#   spec.bindir        = "bin"
#   spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
#   spec.require_paths = ["lib"]
#
#   spec.add_development_dependency "bundler", "~> 1.16"
#   spec.add_development_dependency "rake", "~> 10.0"
#   spec.add_development_dependency "rspec", "~> 3.0"
#   spec.add_development_dependency "pry"
#
#   spec.add_dependency "nokogiri"
#   spec.add_dependency "open_uri_redirections"
# end
