require 'rubygems'
require 'sinatra'
require 'slim'

# Set Sinatra variables
set :app_file, __FILE__
set :root, File.dirname(__FILE__)
set :views, 'views'
set :slim, pretty: true
set :server, :puma

# Set up a logger
require 'logger'
LOGGER = Logger.new($stderr)

# Set up Cassandra
require 'cql'
require 'cql/compression/snappy_compressor'

CASSANDRA_KEYSPACE = 'twissandra'

CASSANDRA = Cql::Client.connect(
  hosts: ['127.0.0.1'],
  compressor: Cql::Compression::SnappyCompressor.new,
  logger: LOGGER)

CASSANDRA.use(CASSANDRA_KEYSPACE)

GET_USERLINE = CASSANDRA.prepare("SELECT * FROM userline WHERE username=? LIMIT ?")

def get_public_userline(maxid=nil, limit=25)
  rows = GET_USERLINE.execute("!PUBLIC!", limit)

  get_tweets(rows.map{|r| r['tweet_id']})
end

GET_TWEET = CASSANDRA.prepare("SELECT * FROM tweets WHERE tweet_id = ?")

def get_tweets(tweet_ids)
  tweet_ids.map do |tweet_id|
    GET_TWEET.execute(tweet_id).first
  end
end

# Application routes
get '/' do
  @tweets = get_public_userline
  slim :index
end
