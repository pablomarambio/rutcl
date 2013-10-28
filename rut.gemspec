# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rut"

Gem::Specification.new do |spec|
  spec.name          = "rutcl"
  spec.version       = Rut::VERSION
  spec.authors       = ["Pablo Marambio"]
  spec.email         = ["yo@pablomarambio.cl"]
  spec.description   = "Validación y formato de RUTs chilenos"
  spec.summary       = "Validación y formato de RUTs chilenos"
  spec.homepage      = "https://github.com/pablomarambio/rutcl"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
end
