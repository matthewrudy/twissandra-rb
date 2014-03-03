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
Cequel::Record.establish_connection(host: '127.0.0.1', keyspace: 'twissandra')

require 'logger'
Cequel::Record.connection.logger = Logger.new($stderr)

class Userline
  include Cequel::Record

  PUBLIC_USERNAME = "!PUBLIC!".freeze

  self.table_name = :userline

  key    :username, :text
  key    :time,     :timeuuid, auto: true
  column :tweet_id, :uuid

  def self.public(maxid=nil, limit=25)
    scope = Userline['!PUBLIC!'].limit(limit)

    if maxid
      scope.before(maxid)
    else
      scope
    end
  end

  def tweet
    @tweet ||= Tweet.find(tweet_id)
  end
end

class Tweet
  include Cequel::Record

  self.table_name = :tweets

  key    :tweet_id, :uuid, auto: true
  column :body,     :text
  column :username, :text
end

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

