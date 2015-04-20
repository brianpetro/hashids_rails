$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "hashids_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "hashids_rails"
  s.version     = HashidsRails::VERSION
  s.authors     = ["Brian Petro"]
  s.email       = ["brian@linkplugapp.com"]
  s.summary     = "Use hashids to mask ActiveRecord IDs in URL."
  s.description = "Store ActiveRecord IDs non-obviously in URL using hashids."
  s.homepage    = "https://github.com/brianpetro/hashids_rails"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.1"
  s.add_dependency "hashids"

  s.add_development_dependency "sqlite3"
end
