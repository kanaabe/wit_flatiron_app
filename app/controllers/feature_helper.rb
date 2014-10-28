class FeatureHelper
  FEED_COUNT = 10

  def self.tweets(name)
    TWITTER.user_timeline("#{name}", :count=>FEED_COUNT)
  end

  def self.github_feed(name)

    the_feed=[]
    url="https://github.com/#{name}.atom"

    open(url) do |rss|
      feed = RSS::Parser.parse(rss)
      feed.items.each do |item|
        the_feed << {time: item.published.content, content: item.title.content}
      end
    end
    the_feed[0..FEED_COUNT-1]
  end

end