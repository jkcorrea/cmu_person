# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = 'cmu-person'
  s.version     = '0.0.3'
  s.author      = 'Seth Vargo'
  s.email       = 'sethvargo@gmail.com'
  s.homepage    = 'https://github.com/sethvargo/cmu-person'
  s.summary     = %q{A simple interface for searching CMU LDAP directory}
  s.description = %q{This tool is used to search Carnegie Mellon's LDAP directory. Provide an Andrew ID and this will automatically parse the results and return them in a readable format.}

  s.rubyforge_project = 'cmu-person'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # development dependencies
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'yard'
  
  # runtime dependencies
  s.add_runtime_dependency 'net-ldap'
end