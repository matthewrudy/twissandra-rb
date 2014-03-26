require_relative './boot'

# Application routes
get '/' do
  @timeline = Userline.public
  slim :index
end

get '/before/:timestamp' do
  maxid = Cql::TimeUuid.new(params[:timestamp])
  @timeline = Userline.public(maxid)
  slim :index
end

post '/tweet' do
  tweet_params = params.fetch("tweet").slice("body", "username")
  tweet = Tweet.create(tweet_params)
  Userline.create(username: Userline::PUBLIC_USERNAME, tweet_id: tweet.tweet_id)

  redirect to('/')
end

