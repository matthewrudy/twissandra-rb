# Boot

require 'cequel'
Cequel::Record.establish_connection(host: '127.0.0.1:9160', keyspace: 'twissandra')

require 'logger'
Cequel::Record.connection.logger = Logger.new($stderr)


# Entities

require_relative './twissandra/entities/follower'
require_relative './twissandra/entities/friend'
require_relative './twissandra/entities/timeline'
require_relative './twissandra/entities/tweet'
require_relative './twissandra/entities/user'
require_relative './twissandra/entities/userline'

# Interactors

require_relative './twissandra/interactors/create_user'
require_relative './twissandra/interactors/follow_user'
require_relative './twissandra/interactors/read_timeline'
require_relative './twissandra/interactors/send_tweet'
require_relative './twissandra/interactors/unfollow_user'
