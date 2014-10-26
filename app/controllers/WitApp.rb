class WitApp < Sinatra::Base
set :views, File.expand_path('../../views', __FILE__)
  get '/' do
    @r = WitHandler.new.message
    erb :'index.html'
  end

end
