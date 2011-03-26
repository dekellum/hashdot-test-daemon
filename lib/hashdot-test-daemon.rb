#--
# Copyright (c) 2010-2011 David Kellum
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

require 'hashdot-test-daemon/base'

require 'rjack-slf4j'
require 'java'

module Hashdot

  module Daemon

    # The mock service
    class Runner
      include RJack

      def initialize
        @log = SLF4J[ self.class ]
        @log.info "Initialized hashdot-daemon (VERSION = #{VERSION})"
        @log.info "SLF4J::VERSION = #{SLF4J::VERSION}"
        ShutdownHandler.register
      end

      def run
        loop do
          i = 2 * rand
          @log.info { "Sleep #{i}" }
          sleep i
          if rand(100) == 0
            cause = rand(3) == 0 ? "KILL" : "TERM"
            @log.info { "Unexpected #{cause}" }
            Process.kill( cause, 0 )
            break
          end
        end
      end

    end

    class ShutdownHandler
      Thread  = Java::java.lang.Thread
      Runtime = Java::java.lang.Runtime

      include Java::java.lang.Runnable
      include RJack

      def run
        SLF4J[self.class].info "Shutting down (sleep 3)"
        sleep 3.0
      end

      def self.register
        Runtime::runtime.add_shutdown_hook( Thread.new( new ) )
      end
    end
  end
end
