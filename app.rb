class WitApp < Sinatra::Base
set :views, File.expand_path('../app/views', __FILE__)

  get '/' do
    erb :'home.html'
  end

  post '/' do
    wit = WitHandler.new

    if params[:intent] == "undefined" 
      i = "get_cassie_tarakajian_profile"
      @profile = wit.pull_profile(i)
    else 
      intent = params[:intent]
      @profile = wit.pull_profile(intent)
    end

    @tweets = FeatureHelper.tweets(@profile.twitter.gsub("https://twitter.com/",""))
    @github = FeatureHelper.github_feed(@profile.github.gsub("https://github.com/",""))
    @profile.img_url
    
    erb :'results.html'
  end


end
