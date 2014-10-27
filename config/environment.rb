require 'bundler/setup'
Bundler.require

ENV["SINATRA_ENV"] ||= "development"

require_all 'app'
require_all 'lib'
require 'open-uri'
require 'json'
require 'rss'

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/people#{ENV["SINATRA_ENV"]}.sqlite"
  )

TWITTER = Twitter::REST::Client.new do |config|
  config.consumer_key = "SOo0mIfGvsFVP7OlrNVaRS7bE"
  config.consumer_secret = "yzNnxhbZknAcIOWXiPAL7UWVrdqr3hBYgLJPs6sTqaYiCVEXHh"
  config.access_token = "276237692-vwCB7oLa5TWBoDFv7MVdap6aDxzAqdVFbpyjrwQM"
  config.access_token_secret = "iXQ7vSO7Rvq8zVnZO3u8LDRMQvTzcHCfTRDUTBB3ZNRk0"
end