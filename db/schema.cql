// Create the KEYSPACE

DROP KEYSPACE IF EXISTS twissandra;

CREATE KEYSPACE twissandra WITH replication = {
  'class': 'SimpleStrategy',
  'replication_factor': '1'
};

USE twissandra;


// Users - a user

CREATE TABLE users (
  id       uuid,
  username text,
  location text,

  PRIMARY KEY (id)
);

CREATE INDEX ON users (username);


// Tweets - a tweet posted by the user

CREATE TABLE tweets (
  id        timeuuid,
  user_id   uuid,
  body      text,
  mentions  set<uuid>,

  PRIMARY KEY (id)
);


// Userline - tweets posted by the user

CREATE TABLE userline (
  user_id  uuid,
  tweet_id timeuuid,

  PRIMARY KEY (user_id, tweet_id)
)

WITH CLUSTERING ORDER BY (tweet_id DESC);


// Timeline - tweets posted by users the user follows

CREATE TABLE timeline (
  user_id       uuid,
  tweet_id      timeuuid,
  tweet_user_id uuid,

  PRIMARY KEY (user_id, tweet_id)
)

WITH CLUSTERING ORDER BY (tweet_id DESC);


// Friends - users who are followed by the user

CREATE TABLE friends (
  user_id   uuid,
  friend_id uuid,
  timestamp timestamp,

  PRIMARY KEY (user_id, friend_id)
);


// Followers - users who are following the user

CREATE TABLE followers (
  user_id     uuid,
  follower_id uuid,
  timestamp   timestamp,

  PRIMARY KEY (user_id, follower_id)
);
