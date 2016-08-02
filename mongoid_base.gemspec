$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "universal/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "universal"
  s.version     = Universal::VERSION
  s.authors     = ["Ben Petro"]
  s.email       = ["benpetro@gmail.com"]
  s.summary     = "Useful concerns and helpers to provide basic Mongodb functionality"
  s.description = "Useful concerns and helpers to provide basic Mongodb functionality"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

end
