class WitApp < Sinatra::Base
set :views, File.expand_path('../../views', __FILE__)
register Sinatra::AssetPack
  assets do
    serve '/js', :from => '../assets/javascripts'
    js :application, [
      'js/helpers.js',
      '/js/microphone.min.js'
    ]
    serve '/css', :from => '../assets/stylesheets'
    css :application, [
      '/css/microphone.min.css',
    ]
    serve '/css/fonts',  from: '../assets/fonts'
    #js_compression :jsmin
    #css_compression :sass
  end

  get '/' do
    erb :'home.html'
  end

  post '/' do
    wit = WitHandler.new
    #i = wit.get_intent
    i = "get_kana_abe_profile"
    #profile = wit.pull_profile(i["outcomes"][0]["intent"])
    @profile = wit.pull_profile(i)

    @tweets = FeatureHelper.tweets("kana_abe")
    @github = FeatureHelper.github_feed("kanaabe")
    
    #@tweets = TWITTER.get_all_tweets("kanaabe")

    #inding.pry
    erb :'results.html'
  end


end
