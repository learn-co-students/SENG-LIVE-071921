ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
require 'sqlite3'
Bundler.require(:default, ENV['SINATRA_ENV'])

DB = SQLite3::Database.new("db/#{ENV['SINATRA_ENV']}.sqlite")
DB.results_as_hash = true

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

require_all 'lib/models'
