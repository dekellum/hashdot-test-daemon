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

FileList[ "init/*" ].exclude( "*~" ).each do |infile|
  file infile => [ 'lib/hashdot-daemon/base.rb' ] do
    changed = false
    out = []
    open( infile ) do |inf|
      inf.each do |line|
        if ( !changed &&
             line =~ /^gem[\(]?\s*["']#{t.name}["']\s*,\s*["']\s*[>=~]+\s*([0-9\.]+)["']\s*[\)]?\s*#auto-update\s*$/ )
          if $1 != t.version
            out << line.sub( $1, t.version )
            changed = true
          else
            break
          end
        else
            out << line
        end
      end
    end

    if changed
      cp( infile, infile + '~', :preserve => true )
      puts "#{infile} -> #{t.version}"
      open( infile, 'w' ) { |otf| otf.puts out }
    end

  end
end
