require 'bundler/setup'
Bundler.require

require_all 'app'
require_all 'lib'
require_relative '../app.rb'
require 'open-uri'
require 'json'
require 'rss'
require 'time'

configure :development do 
  ENV["SINATRA_ENV"] = "development"
  ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/people#{ENV["SINATRA_ENV"]}.sqlite"
  )
end

configure :production do 
  ENV["SINATRA_ENV"] ||= "production"
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///localhost/mydb')

  ActiveRecord::Base.establish_connection(
   :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
   :host     => db.host,
   :username => db.user,
   :password => db.password,
   :database => db.path[1..-1],
   :encoding => 'utf8'
  )
end

TWITTER = Twitter::REST::Client.new do |config|
  config.consumer_key = "HuN9aigm7Ho7tSaGMtkjk2UaG"
  config.consumer_secret = "8ZrTHlRguLQLGtzWIvFSQ5DOLcGD3NWOfySF3tuZxPPp8ENHwQ"
  config.access_token = "1217406620-zxeCuOfA8ez20heFf7F1zbSb2LtDhPqwrSEOz9d"
  config.access_token_secret = "KukhBvaIaZbxhMxpnRAhhPHvzIyUMa3A3tSvZtbvMn23T"
end