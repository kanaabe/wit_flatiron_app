require 'bundler/setup'
Bundler.require

ENV["SINATRA_ENV"] ||= "development"

require_all 'app'
require_all 'lib'
require 'open-uri'
require 'json'

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/people#{ENV["SINATRA_ENV"]}.sqlite"
  )

TWITTER = Twitter::REST::Client.new do |config|

end