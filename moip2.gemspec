# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'moip2/version'

Gem::Specification.new do |spec|
  spec.name          = "moip2"
  spec.version       = Moip2::VERSION
  spec.authors       = ["Rodrigo Saito", "Danillo Souza", "Caio Gama"]
  spec.email         = ["rodrigo.saito@moip.com.br", "danillo.souza@moip.com.br", "caio.gama@moip.com.br"]
  spec.summary       = %q{Ruby client for moip v2 api}
  spec.description   = %q{Ruby client for moip v2 api}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty"
  spec.add_dependency "recursive-open-struct"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "codeclimate-test-reporter"
end
