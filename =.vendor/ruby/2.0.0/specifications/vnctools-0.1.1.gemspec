# -*- encoding: utf-8 -*-
# stub: vnctools 0.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "vnctools".freeze
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jari Bakken".freeze]
  s.date = "2014-07-08"
  s.description = "Simple CLI wrappers to control and record VNC displays from Ruby.".freeze
  s.email = ["jari.bakken@gmail.com".freeze]
  s.homepage = "".freeze
  s.rubyforge_project = "vnctools".freeze
  s.rubygems_version = "2.6.13".freeze
  s.summary = "Simple CLI wrappers to control and record VNC displays from Ruby.".freeze

  s.installed_by_version = "2.6.13" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<childprocess>.freeze, [">= 0"])
      s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 2.5"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 0.9.2"])
    else
      s.add_dependency(%q<childprocess>.freeze, [">= 0"])
      s.add_dependency(%q<simplecov>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 2.5"])
      s.add_dependency(%q<rake>.freeze, ["~> 0.9.2"])
    end
  else
    s.add_dependency(%q<childprocess>.freeze, [">= 0"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 2.5"])
    s.add_dependency(%q<rake>.freeze, ["~> 0.9.2"])
  end
end
