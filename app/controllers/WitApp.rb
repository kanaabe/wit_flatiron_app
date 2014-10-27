class WitApp < Sinatra::Base
set :views, File.expand_path('../../views', __FILE__)
register Sinatra::AssetPack
  assets do
    serve '/js', :from => '../assets/javascripts'
    js :application, [
      'js/jquery-1.11.1.min.js',
      'js/helpers.js',
      '/js/microphone.min.js'
    ]
    serve '/css', :from => '../assets/stylesheets'
    css :application, [
      '/css/microphone.min.css',
      '/css/style.css'
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
    #intent = params[:intent]
    #profile = wit.pull_profile(intent)
    i = "get_kana_abe_profile"
    @profile = wit.pull_profile(i)

    @tweets = FeatureHelper.tweets(@profile.twitter.gsub("https://twitter.com/",""))
    #@tweets = FeatureHelper.tweets("flatironschool")
    @github = FeatureHelper.github_feed(@profile.github.gsub("https://github.com/",""))
    #binding.pry
    #@tweets = TWITTER.get_all_tweets("kanaabe")

    #inding.pry
    erb :'results.html'
  end


end
