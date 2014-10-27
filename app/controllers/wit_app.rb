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
    #@profile = wit.pull_profile(intent)
     i = "get_cassie_tarakajian_profile"
     @profile = wit.pull_profile(i)

    @tweets = FeatureHelper.tweets(@profile.twitter.gsub("https://twitter.com/",""))
    @github = FeatureHelper.github_feed(@profile.github.gsub("https://github.com/",""))
    @profile.img_url
    
    erb :'results.html'
  end


end
