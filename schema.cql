## Entities

### Users - a user

CREATE TABLE users (
  uuid     uuid,
  username text,
  location text

  PRIMARY KEY (uuid)
);


### Tweets - a tweet posted by the user

CREATE TABLE tweets (
  uuid      timeuuid,
  user_uuid uuid,
  body      text,
  mentions  set<uuid>,

  PRIMARY KEY (uuid)
);


### Userline - tweets posted by the user

CREATE TABLE userline (
  user_uuid uuid,
  tweet_uuid timeuuid,

  PRIMARY KEY (user_uuid, tweet_uuid)
)

WITH CLUSTERING ORDER BY (tweet_uuid DESC);


### Timeline - tweets posted by users the user follows

CREATE TABLE timeline (
  user_uuid       uuid,
  tweet_uuid      timeuuid,
  tweet_user_uuid uuid,

  PRIMARY KEY (user_uuid, tweet_uuid)
)

WITH CLUSTERING ORDER BY (tweet_uuid DESC);


### Friends - users who are followed by the user

CREATE TABLE friends (
  user_uuid   uuid,
  friend_uuid uuid,
  timestamp   timestamp,

  PRIMARY KEY (user_uuid, friend_uuid)
);


### Followers - users who are following the user

CREATE TABLE followers (
  user_uuid   uuid,
  follower_uuid uuid,
  timestamp   timestamp,

  PRIMARY KEY (user_uuid, follower_uuid)
);
