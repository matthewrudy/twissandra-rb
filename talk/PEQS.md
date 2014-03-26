# P.E.Q.S.


## Processes

* Creating a User
* Sending a Tweet
* Reading my Timeline
* Following a User
* Unfollowing a User

### Creating a User

* store User details

### Sending a Tweet

* create a Tweet for Me
* add Tweet to my Followers Timelines
* add Tweet to *mentioned* users' Timeline

### Reading my Timeline

* find Tweets from my Timeline
* load the Tweet details
* load the User details

### Following a User

* add User to my Friends
* add Me to the User's Followers
* add User's Tweets to my Timeline

### Unfollowing a User

* remove User from my Friends
* remove Me from User's Followers
* remove User's Tweets from my Timeline


## Entities

### Users - a user

* uuid     - uuid
* username - varchar
* location - text - an example of user metadata

Unique by `uuid`

### Tweets - a tweet posted by the user

* uuid      - timeuuid - this is a combination of a a timestamp and a unique id
* user_uuid - uuid
* body      - text
* mentions  - set(uuid)

Unique by `uuid`

### Userline - tweets posted by the user

* user_uuid  - uuid
* tweet_uuid - timeuuid

Unique by `{user_uuid, tweet_uuid}`

### Timeline - tweets posted by users the user follows

* user_uuid       - uuid
* tweet_uuid      - timeuuid
* tweet_user_uuid - uuid - make it easy to remove tweets when we unfollow a user

Unique by `{user_uuid, tweet_uuid}`

### Friends - users who are followed by the user

* user_uuid   - uuid
* friend_uuid - uuid
* timestamp   - timestamp

Unique by `{user_uuid, friend_uuid}`

### Followers - users who are following the user

* user_uuid   - uuid
* friend_uuid - uuid
* timestamp   - timestamp

Unique by `{user_uuid, friend_uuid}`


## Queries

### Users

* find_by_uuid     - returns User object with the uuid
* find_by_username - returns User object with the requested username
* find_all_following - returns User objects which follow User

### Tweets

* find_by_uuid - returns Tweet object with the requested uuid


### Userline

* find

* user_uuid  - uuid
* tweet_uuid - timeuuid

Unique by `{user_uuid, tweet_uuid}`

### Timeline - tweets posted by users the user follows

* user_uuid       - uuid
* tweet_uuid      - timeuuid
* tweet_user_uuid - uuid - make it easy to remove tweets when we unfollow a user

Unique by `{user_uuid, tweet_uuid}`

### Friends - users who are followed by the user

* user_uuid   - uuid
* friend_uuid - uuid
* timestamp   - timestamp

Unique by `{user_uuid, friend_uuid}`

### Followers - users who are following the user

* user_uuid   - uuid
* friend_uuid - uuid
* timestamp   - timestamp

Unique by `{user_uuid, friend_uuid}`
