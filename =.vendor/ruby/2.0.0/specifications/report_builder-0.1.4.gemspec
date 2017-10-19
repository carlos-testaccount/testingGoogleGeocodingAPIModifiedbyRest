# -*- encoding: utf-8 -*-
# stub: report_builder 0.1.4 ruby lib

Gem::Specification.new do |s|
  s.name = "report_builder".freeze
  s.version = "0.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Rajat Thareja".freeze]
  s.date = "2016-03-17"
  s.description = "Merge Cucumber JSON reports and build single HTML Test Report".freeze
  s.email = "rajat.thareja.1990@gmail.com".freeze
  s.executables = ["report_builder".freeze]
  s.files = ["bin/report_builder".freeze]
  s.homepage = "https://github.com/rajatthareja/ReportBuilder".freeze
  s.licenses = ["MIT".freeze]
  s.post_install_message = "Happy reporting!".freeze
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.1".freeze)
  s.requirements = ["Cucumber >= 2.1.0 test results in JSON format".freeze]
  s.rubygems_version = "2.6.13".freeze
  s.summary = "ReportBuilder".freeze

  s.installed_by_version = "2.6.13" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<builder>.freeze, [">= 3.2.2", "~> 3.2"])
      s.add_runtime_dependency(%q<json>.freeze, [">= 1.8.1"])
      s.add_development_dependency(%q<rake>.freeze, ["< 13.0"])
      s.add_development_dependency(%q<rspec>.freeze, ["< 4.0"])
    else
      s.add_dependency(%q<builder>.freeze, [">= 3.2.2", "~> 3.2"])
      s.add_dependency(%q<json>.freeze, [">= 1.8.1"])
      s.add_dependency(%q<rake>.freeze, ["< 13.0"])
      s.add_dependency(%q<rspec>.freeze, ["< 4.0"])
    end
  else
    s.add_dependency(%q<builder>.freeze, [">= 3.2.2", "~> 3.2"])
    s.add_dependency(%q<json>.freeze, [">= 1.8.1"])
    s.add_dependency(%q<rake>.freeze, ["< 13.0"])
    s.add_dependency(%q<rspec>.freeze, ["< 4.0"])
  end
end
