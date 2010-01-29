# -*- ruby -*-
#--
# Copyright (C) 2008-2009 David Kellum
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
gem     'rjack-tarpit', '~> 1.1.0'
require 'rjack-tarpit'

t = RJack::TarPit.new( 'hashdot-daemon', Hashdot::Daemon::VERSION )

t.specify do |h|
  h.developer( "David Kellum", "dek-oss@gravitext.com" )
  h.extra_deps     << [ 'rjack-slf4j',   '~> 1.5.8.0'  ]
  h.extra_dev_deps << [ 'rjack-logback', '~> 0.9.17.0' ]
end

t.define_tasks

FileList[ "init/*.erb" ].each do |efile|
  b = binding
  version = t.version
  ifile = efile.sub( /\.erb$/, '' )
  file ifile => [ efile, 'lib/hashdot-daemon/base.rb' ] do
    require 'erb'
    puts "#{efile} --generate--> #{ifile}"
    open( ifile, 'w' ) do |outf|
      outf.write( ERB.new( IO.read( efile ) ).result( b ) )
    end
  end
end
