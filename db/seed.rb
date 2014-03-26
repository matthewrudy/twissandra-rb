require_relative '../app/boot'
require 'cql/uuid'

# create the "me" user

me = Twissandra::CreateUser.perform(username: "me")[:user]

# create the Matthew user

matthewrudy = Twissandra::CreateUser.perform(username: "matthewrudy")[:user]

# then follow him before he tweets

Twissandra::FollowUser.perform(me, matthewrudy)

# Matthew is going to tweet some stuff

["Hi, nice to meet you all.", "My name's Matthew", "Where are you from?", "I'm from St Albans"].each do |message_body|
  Twissandra::SendTweet.perform(matthewrudy, body: message_body)
end

# create the Raffi user

raffi = Twissandra::CreateUser.perform(username: "raffi")[:user]

# Raffi is going to tweet before we follow him

["Hi, nice to meet you all.", "My name's Raffi", "I'm Matthew's brother.", "I'm also from St Albans"].each do |message_body|
  Twissandra::SendTweet.perform(raffi, body: message_body)
end

# Then we'll follow him

Twissandra::FollowUser.perform(me, raffi)

