require 'bundler/setup'
Bundler.require

ENV["SINATRA_ENV"] ||= "development"

require_all 'app'
require_all 'lib'
require 'open-uri'
require 'json'
require 'rss'
require 'time'

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/people#{ENV["SINATRA_ENV"]}.sqlite"
  )

TWITTER = Twitter::REST::Client.new do |config|
  config.consumer_key = "HuN9aigm7Ho7tSaGMtkjk2UaG"
  config.consumer_secret = "8ZrTHlRguLQLGtzWIvFSQ5DOLcGD3NWOfySF3tuZxPPp8ENHwQ"
  config.access_token = "1217406620-zxeCuOfA8ez20heFf7F1zbSb2LtDhPqwrSEOz9d"
  config.access_token_secret = "KukhBvaIaZbxhMxpnRAhhPHvzIyUMa3A3tSvZtbvMn23T"
end