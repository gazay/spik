$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "spik/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "spik"
  s.version     = Spik::VERSION
  s.authors     = ["Alexey Gaziev"]
  s.email       = ["alex.gaziev@gmail.com"]
  # s.homepage    = "TODO"
  s.summary     = "Imperative speaking with Rails"
  s.description = "You can say something and controller understands you"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]
  # 
  # s.add_dependency "rails", "~> 3.1.1"
  # 
  # s.add_development_dependency "sqlite3"
end
