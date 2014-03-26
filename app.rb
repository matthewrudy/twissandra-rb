require 'rubygems'
require 'sinatra'
require 'slim'

# Set Sinatra variables
set :app_file, __FILE__
set :root, File.dirname(__FILE__)
set :views, 'views'
set :slim, pretty: true
set :server, :puma

require 'cequel'
Cequel::Record.establish_connection(host: '127.0.0.1:9160', keyspace: 'twissandra')

require 'logger'
Cequel::Record.connection.logger = Logger.new($stderr)

require 'twissandra'

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

