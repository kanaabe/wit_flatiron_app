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
    @r = WitHandler.new.pull_profile

    erb :'index.html'
  end

end
