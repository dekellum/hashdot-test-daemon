# -*- ruby -*-
#--
# Copyright (C) 2010 David Kellum
#
# Licensed under the Apache License, Version 2.0 (the "License"); you
# may not use this file except in compliance with the License.  You
# may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.  See the License for the specific language governing
# permissions and limitations under the License.
#++

$LOAD_PATH << './lib'
require 'hashdot-daemon/base'

require 'rubygems'
gem     'rjack-tarpit', '~> 1.2.0'
require 'rjack-tarpit'

t = RJack::TarPit.new( 'hashdot-daemon', Hashdot::Daemon::VERSION )

t.specify do |h|
  h.developer( "David Kellum", "dek-oss@gravitext.com" )
  h.extra_deps += [ [ 'rjack-slf4j',   '~> 1.5.8.0'  ],
                    [ 'rjack-logback', '~> 0.9.17.0' ] ]
end

task :check_init_versions do
  t.test_line_match( 'init/hashdot-daemon',
                      /^gem.+#{t.name}/, /= #{t.version}/ )
end

task :check_history_version do
  t.test_line_match( 'History.rdoc', /^==/, / #{t.version} / )
end
task :check_history_date do
  t.test_line_match( 'History.rdoc', /^==/, /\([0-9\-]\)$/ )
end

task :gem  => [ :check_init_versions, :check_history_version ]
task :push => [ :check_history_date ]

t.define_tasks
