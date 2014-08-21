# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'api/fom/client/version'

Gem::Specification.new do |spec|
  spec.name          = "api-fom-client"
  spec.version       = API::FOM::Client::VERSION
  spec.authors       = ["Metin Yorulmaz"]
  spec.email         = ["metin@me.com"]
  spec.summary       = %q{FOM Client}
  spec.description   = %q{FOM Client}
  spec.homepage      = "http://beybun.dev"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
