$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "atlys_mobile_app/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "atlys_mobile_app"
  s.version     = AtlysMobileApp::VERSION
  s.authors     = ["hunterlong"]
  s.email       = ["info@socialeck.com"]
  s.homepage    = ""
  s.summary     = "Summary of AtlysMobileApp."
  s.description = "Description of AtlysMobileApp."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 4.2.6", "< 5.1"

  s.add_dependency "rubyzip"

end
