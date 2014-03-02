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

def get_public_userline
  CASSANDRA.execute("SELECT * FROM userline WHERE username=?", "!PUBLIC!")
end

# Application routes
get '/' do
  @tweets = get_public_userline
  slim :index
end
