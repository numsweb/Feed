# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{feedzirra}
  s.version = "0.0.31"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Paul Dix", "Julien Kirch"]
  s.date = %q{2011-08-19}
  s.description = %q{A feed fetching and parsing library that treats the internet like Godzilla treats Japan: it dominates and eats all.}
  s.email = %q{feedzirra@googlegroups.com}
  s.files = ["spec/benchmarks/feed_benchmarks.rb", "spec/benchmarks/feedzirra_benchmarks.rb", "spec/benchmarks/fetching_benchmarks.rb", "spec/benchmarks/parsing_benchmark.rb", "spec/benchmarks/updating_benchmarks.rb", "spec/feedzirra/feed_entry_utilities_spec.rb", "spec/feedzirra/feed_spec.rb", "spec/feedzirra/feed_utilities_spec.rb", "spec/feedzirra/parser/atom_entry_spec.rb", "spec/feedzirra/parser/atom_feed_burner_entry_spec.rb", "spec/feedzirra/parser/atom_feed_burner_spec.rb", "spec/feedzirra/parser/atom_spec.rb", "spec/feedzirra/parser/itunes_rss_item_spec.rb", "spec/feedzirra/parser/itunes_rss_owner_spec.rb", "spec/feedzirra/parser/itunes_rss_spec.rb", "spec/feedzirra/parser/rss_entry_spec.rb", "spec/feedzirra/parser/rss_spec.rb", "spec/sample_feeds/run_against_sample.rb", "spec/spec_helper.rb"]
  s.homepage = %q{http://github.com/pauldix/feedzirra}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{A feed fetching and parsing library}
  s.test_files = ["spec/benchmarks/feed_benchmarks.rb", "spec/benchmarks/feedzirra_benchmarks.rb", "spec/benchmarks/fetching_benchmarks.rb", "spec/benchmarks/parsing_benchmark.rb", "spec/benchmarks/updating_benchmarks.rb", "spec/feedzirra/feed_entry_utilities_spec.rb", "spec/feedzirra/feed_spec.rb", "spec/feedzirra/feed_utilities_spec.rb", "spec/feedzirra/parser/atom_entry_spec.rb", "spec/feedzirra/parser/atom_feed_burner_entry_spec.rb", "spec/feedzirra/parser/atom_feed_burner_spec.rb", "spec/feedzirra/parser/atom_spec.rb", "spec/feedzirra/parser/itunes_rss_item_spec.rb", "spec/feedzirra/parser/itunes_rss_owner_spec.rb", "spec/feedzirra/parser/itunes_rss_spec.rb", "spec/feedzirra/parser/rss_entry_spec.rb", "spec/feedzirra/parser/rss_spec.rb", "spec/sample_feeds/run_against_sample.rb", "spec/spec_helper.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>, ["~> 1.4.4"])
      s.add_runtime_dependency(%q<sax-machine>, ["~> 0.0.20"])
      s.add_runtime_dependency(%q<curb>, ["~> 0.7.15"])
      s.add_runtime_dependency(%q<builder>, ["~> 3.0.0"])
      s.add_runtime_dependency(%q<activesupport>, [">= 3.0.8"])
      s.add_runtime_dependency(%q<loofah>, ["~> 1.0.0"])
      s.add_runtime_dependency(%q<rdoc>, ["~> 3.8"])
      s.add_runtime_dependency(%q<rake>, [">= 0.9.2"])
      s.add_runtime_dependency(%q<i18n>, [">= 0.5.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.6.0"])
    else
      s.add_dependency(%q<nokogiri>, ["~> 1.4.4"])
      s.add_dependency(%q<sax-machine>, ["~> 0.0.20"])
      s.add_dependency(%q<curb>, ["~> 0.7.15"])
      s.add_dependency(%q<builder>, ["~> 3.0.0"])
      s.add_dependency(%q<activesupport>, [">= 3.0.8"])
      s.add_dependency(%q<loofah>, ["~> 1.0.0"])
      s.add_dependency(%q<rdoc>, ["~> 3.8"])
      s.add_dependency(%q<rake>, [">= 0.9.2"])
      s.add_dependency(%q<i18n>, [">= 0.5.0"])
      s.add_dependency(%q<rspec>, ["~> 2.6.0"])
    end
  else
    s.add_dependency(%q<nokogiri>, ["~> 1.4.4"])
    s.add_dependency(%q<sax-machine>, ["~> 0.0.20"])
    s.add_dependency(%q<curb>, ["~> 0.7.15"])
    s.add_dependency(%q<builder>, ["~> 3.0.0"])
    s.add_dependency(%q<activesupport>, [">= 3.0.8"])
    s.add_dependency(%q<loofah>, ["~> 1.0.0"])
    s.add_dependency(%q<rdoc>, ["~> 3.8"])
    s.add_dependency(%q<rake>, [">= 0.9.2"])
    s.add_dependency(%q<i18n>, [">= 0.5.0"])
    s.add_dependency(%q<rspec>, ["~> 2.6.0"])
  end
end
