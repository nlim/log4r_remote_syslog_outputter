# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "log4r_remote_syslog_outputter/version"

Gem::Specification.new do |s|
  s.name        = "log4r_remote_syslog_outputter"
  s.version     = Log4rRemoteSyslogOutputter::VERSION
  s.authors     = ["Rob Hanlon"]
  s.email       = ["rob@mediapiston.com"]
  s.homepage    = "http://www.mediapiston.com/"
  s.summary     = %q{A Log4r outputter that outputs via remote syslog}
  s.description = %q{The outputter included in this library simply ties Log4r's Outputter interface together with remote_syslog_logger.}

  s.add_dependency('log4r', '>= 1.1.9')
  s.add_dependency('remote_syslog_logger', '>= 1.0.3')

  s.add_dependency('rspec', '>= 2.7.0')

  s.rubyforge_project = "log4r_remote_syslog_outputter"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
