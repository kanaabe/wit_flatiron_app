class FeatureHelper

  def self.tweets(name)
    TWITTER.user_timeline(:user =>"#{name}", :count=>15)
  end

  def self.github_feed(name)

    the_feed=[]
    url="https://github.com/#{name}.atom"

    open(url) do |rss|
      feed = RSS::Parser.parse(rss)
      feed.items.each do |item|
        i=[]
        i << item.title.content
        #i << item.updated.content
        the_feed << i
      end
    end
    #binding.pry
    the_feed
  end

end