$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "hashids_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "hashids_rails"
  s.version     = HashidsRails::VERSION
  s.authors     = ["Brian Petro"]
  s.email       = ["brian@plexm.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of HashidsRails."
  s.description = "TODO: Description of HashidsRails."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.1"
  s.add_dependency "hashids"

  s.add_development_dependency "sqlite3"
end
