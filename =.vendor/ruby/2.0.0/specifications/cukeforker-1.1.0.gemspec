# -*- encoding: utf-8 -*-
# stub: cukeforker 1.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "cukeforker".freeze
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jari Bakken".freeze, "Wallace Harwood".freeze, "Jarod Adair".freeze]
  s.date = "2016-03-25"
  s.description = "Library to maintain a forking queue of Cucumber processes, with optional VNC displays.".freeze
  s.email = ["jari.bakken@gmail.com".freeze, "wallaceh@gmail.com".freeze, "adairjk@gmail.com".freeze]
  s.executables = ["cukeforker".freeze]
  s.files = ["bin/cukeforker".freeze]
  s.homepage = "".freeze
  s.rubyforge_project = "cukeforker".freeze
  s.rubygems_version = "2.6.13".freeze
  s.summary = "Library to maintain a forking queue of Cucumber processes".freeze

  s.installed_by_version = "2.6.13" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<cucumber>.freeze, [">= 2.0.0"])
      s.add_runtime_dependency(%q<vnctools>.freeze, [">= 0.0.5"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 2.5"])
      s.add_development_dependency(%q<coveralls>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 0.9.2"])
      s.add_development_dependency(%q<pry>.freeze, [">= 0"])
    else
      s.add_dependency(%q<cucumber>.freeze, [">= 2.0.0"])
      s.add_dependency(%q<vnctools>.freeze, [">= 0.0.5"])
      s.add_dependency(%q<rspec>.freeze, ["~> 2.5"])
      s.add_dependency(%q<coveralls>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, ["~> 0.9.2"])
      s.add_dependency(%q<pry>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<cucumber>.freeze, [">= 2.0.0"])
    s.add_dependency(%q<vnctools>.freeze, [">= 0.0.5"])
    s.add_dependency(%q<rspec>.freeze, ["~> 2.5"])
    s.add_dependency(%q<coveralls>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, ["~> 0.9.2"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
  end
end
