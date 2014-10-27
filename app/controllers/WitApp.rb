class WitApp < Sinatra::Base
set :views, File.expand_path('../../views', __FILE__)
register Sinatra::AssetPack
  assets do
    serve '/js', :from => '../assets/javascripts'
    js :application, [
      '/js/*.js',
    ]
    serve '/css', :from => '../assets/stylesheets'
    css :application, [
      '/css/*.css',
      '/css/*.sass'
     ]
     js_compression :jsmin
     css_compression :sass
  end

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

    #@tweets = TWITTER.get_all_tweets("kanaabe")

    @tweets = TWITTER.user_timeline(:user =>"kana_abe", :count=>15)

    #inding.pry
    erb :'index.html'
  end


end
