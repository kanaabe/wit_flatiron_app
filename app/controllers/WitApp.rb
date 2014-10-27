class WitApp < Sinatra::Base
set :views, File.expand_path('../../views', __FILE__)

  get '/' do
    wit = WitHandler.new
    #i = wit.get_intent
    i = "get_kana_abe_profile"
    #profile = wit.pull_profile(i["outcomes"][0]["intent"])
    profile = wit.pull_profile(i)

    @name = profile.name
    @github = profile.github
    @twitter = profile.twitter
    @linkedin = profile.linkedin
    @biography = profile.biography
    @tweets = FeatureHelper.tweets("kana_abe")
    #@github = FeatureHelper.github_feed("kanaabe")
    
    erb :'index.html'
  end


end
