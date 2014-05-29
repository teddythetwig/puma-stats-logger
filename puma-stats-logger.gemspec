# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'puma_stats_logger/version'

Gem::Specification.new do |spec|
  spec.name          = "puma-stats-logger"
  spec.version       = PumaStatsLogger::VERSION
  spec.authors       = ["Hired, Inc", "Nate Clark"]
  spec.email         = ["opensource@hired.com"]
  spec.summary       = %q{A Rack middleware that collects stats from Puma webserver and outputs them for logging }
  spec.description   = %q{A Rack middleware that collects stats from Puma webserver and outputs them for logging }
  spec.homepage      = "https://github.com/hired/puma-stats-logger"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_dependency "json"

end