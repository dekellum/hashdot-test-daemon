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

require 'hashdot-daemon/base'

require 'rjack-slf4j'

module Hashdot
  module Daemon
    class Runner
      include RJack
      def initialize
        @log = SLF4J[self.class]
        @log.info "Initialized (SLF4J::VERSION = #{SLF4J::VERSION})"
      end

      def run
        @log.info( "started, sleeping..." )
        sleep 9000
      end
    end
  end
end
