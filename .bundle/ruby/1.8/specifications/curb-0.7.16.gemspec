# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{curb}
  s.version = "0.7.16"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ross Bamford", "Todd A. Fisher"]
  s.date = %q{2011-11-03}
  s.description = %q{Curb (probably CUrl-RuBy or something) provides Ruby-language bindings for the libcurl(3), a fully-featured client-side URL transfer library. cURL and libcurl live at http://curl.haxx.se/}
  s.email = %q{todd.fisher@gmail.com}
  s.extensions = ["ext/extconf.rb"]
  s.files = ["tests/alltests.rb", "tests/bug_crash_on_debug.rb", "tests/bug_curb_easy_blocks_ruby_threads.rb", "tests/bug_curb_easy_post_with_string_no_content_length_header.rb", "tests/bug_instance_post_differs_from_class_post.rb", "tests/bug_multi_segfault.rb", "tests/bug_postfields_crash.rb", "tests/bug_postfields_crash2.rb", "tests/bug_require_last_or_segfault.rb", "tests/bugtests.rb", "tests/helper.rb", "tests/mem_check.rb", "tests/require_last_or_segfault_script.rb", "tests/tc_curl_download.rb", "tests/tc_curl_easy.rb", "tests/tc_curl_easy_setopt.rb", "tests/tc_curl_multi.rb", "tests/tc_curl_postfield.rb", "tests/timeout.rb", "tests/timeout_server.rb", "tests/unittests.rb", "ext/extconf.rb"]
  s.homepage = %q{http://curb.rubyforge.org/}
  s.require_paths = ["lib", "ext"]
  s.rubyforge_project = %q{curb}
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Ruby libcurl bindings}
  s.test_files = ["tests/alltests.rb", "tests/bug_crash_on_debug.rb", "tests/bug_curb_easy_blocks_ruby_threads.rb", "tests/bug_curb_easy_post_with_string_no_content_length_header.rb", "tests/bug_instance_post_differs_from_class_post.rb", "tests/bug_multi_segfault.rb", "tests/bug_postfields_crash.rb", "tests/bug_postfields_crash2.rb", "tests/bug_require_last_or_segfault.rb", "tests/bugtests.rb", "tests/helper.rb", "tests/mem_check.rb", "tests/require_last_or_segfault_script.rb", "tests/tc_curl_download.rb", "tests/tc_curl_easy.rb", "tests/tc_curl_easy_setopt.rb", "tests/tc_curl_multi.rb", "tests/tc_curl_postfield.rb", "tests/timeout.rb", "tests/timeout_server.rb", "tests/unittests.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
