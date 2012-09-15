# -*- ruby -*-

gem 'rjack-tarpit', '~> 2.0'
require 'rjack-tarpit/spec'

RJack::TarPit.specify do |s|
  require 'hashdot-test-daemon/base'

  s.version = Hashdot::Daemon::VERSION

  s.add_developer( 'David Kellum', 'dek-oss@gravitext.com' )

  s.depend 'rjack-slf4j',           '>= 1.6.5', '< 1.8'
  s.depend 'rjack-logback',         '~> 1.2'

  s.depend 'minitest',              '~> 2.2',       :dev

  s.platform = :java
end
