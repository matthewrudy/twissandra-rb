require_relative '../app/boot'
require 'cql/uuid'

# create the "me" user

me = Twissandra::CreateUser.perform(username: "me")[:user]

# create the Matthew user

matthewrudy = Twissandra::CreateUser.perform(username: "matthewrudy")[:user]
Twissandra::FollowUser.perform(me, matthewrudy)

# Matthew is going to tweet some stuff

["Hi, nice to meet you all.", "My name's Matthew", "Where are you from?", "I'm from St Albans"].each do |message_body|
  Twissandra::SendTweet.perform(matthewrudy, body: message_body)
end
