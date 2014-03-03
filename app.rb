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

  self.table_name = :userline

  key    :username, :text
  key    :time,     :timeuuid
  column :tweet_id, :uuid

  def tweet
    @tweet ||= Tweet.find(tweet_id)
  end
end

class Tweet
  include Cequel::Record

  self.table_name = :tweets

  key    :tweet_id, :uuid
  column :body,     :text
  column :username, :text
end

def get_public_userline(maxid=nil, limit=25)
  scope = Userline['!PUBLIC!'].limit(limit)

  if maxid
    scope.before(maxid)
  else
    scope
  end
end

# Application routes
get '/' do
  @timeline = get_public_userline
  slim :index
end

get '/before/:timestamp' do
  maxid = Cql::TimeUuid.new(params[:timestamp])
  @timeline = get_public_userline(maxid)
  slim :index
end
