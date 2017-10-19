# -*- encoding: utf-8 -*-
# stub: cuke_sniffer 0.0.8 ruby lib

Gem::Specification.new do |s|
  s.name = "cuke_sniffer".freeze
  s.version = "0.0.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Robert Cochran".freeze, "Chris Vaughn".freeze, "Robert Anderson".freeze]
  s.date = "2014-04-01"
  s.description = "A ruby library used to root out smells in your cukes.".freeze
  s.email = "cochrarj@miamioh.edu".freeze
  s.executables = ["cuke_sniffer".freeze]
  s.files = ["bin/cuke_sniffer".freeze]
  s.homepage = "https://github.com/r-cochran/cuke_sniffer".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.13".freeze
  s.summary = "CukeSniffer".freeze

  s.installed_by_version = "2.6.13" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<roxml>.freeze, [">= 0"])
    else
      s.add_dependency(%q<roxml>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<roxml>.freeze, [">= 0"])
  end
end
