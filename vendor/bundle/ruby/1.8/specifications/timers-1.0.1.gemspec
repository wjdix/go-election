# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{timers}
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tony Arcieri"]
  s.date = %q{2012-07-16}
  s.description = %q{Pure Ruby one-shot and periodic timers}
  s.email = ["tony.arcieri@gmail.com"]
  s.files = [".gitignore", ".rspec", ".travis.yml", "CHANGES.md", "Gemfile", "LICENSE", "README.md", "Rakefile", "lib/timers.rb", "lib/timers/version.rb", "spec/spec_helper.rb", "spec/timers_spec.rb", "timers.gemspec"]
  s.homepage = %q{https://github.com/tarcieri/timers}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Schedule procs to run after a certain time, or at periodic intervals, using any API that accepts a timeout}
  s.test_files = ["spec/spec_helper.rb", "spec/timers_spec.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
