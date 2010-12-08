# -*- ruby -*-

$LOAD_PATH << './lib'
require 'hashdot-test-daemon/base'

require 'rubygems'
gem     'rjack-tarpit', '~> 1.2.0'
require 'rjack-tarpit'

t = RJack::TarPit.new( 'hashdot-test-daemon',
                       Hashdot::Daemon::VERSION,
                       :java_platform )

t.specify do |h|
  h.developer( "David Kellum", "dek-oss@gravitext.com" )
  h.extra_deps += [ [ 'rjack-slf4j',   '~> 1.6.1' ],
                    [ 'rjack-logback', '~> 1.0.0' ] ]
end

task :check_init_versions do
  t.test_line_match( 'init/hashdot-test-daemon',
                      /^gem.+#{t.name}/, /= #{t.version}/ )
end
task :check_history_version do
  t.test_line_match( 'History.rdoc', /^==/, / #{t.version} / )
end
task :check_history_date do
  t.test_line_match( 'History.rdoc', /^==/, /\([0-9\-]+\)$/ )
end

task :gem  => [ :check_init_versions, :check_history_version ]
task :tag  => [ :check_init_versions, :check_history_version, :check_history_date ]
task :push => [ :check_init_versions, :check_history_version, :check_history_date ]

t.define_tasks
