require_relative 'config/environment'

#set :views, File.expand_path('app/view', __FILE__)

class WitApp < Sinatra::Base

  get '/' do
    @r = WitController.new.message
    #puts "RESPONSE HERE: #{@response}"
    #erb :'app/view/index.html'
    #@response = "HELLO IS THE BASIC PAGE WORKING?"
    erb :'index.html'
  end

end
