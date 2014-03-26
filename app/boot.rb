require 'rubygems'
require 'sinatra'
require 'slim'

$LOAD_PATH << File.expand_path("../../lib", __FILE__)

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

require 'twissandra'
