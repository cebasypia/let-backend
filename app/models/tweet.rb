class Tweet
  # プロパティの設定
  attr_accessor :id, :text, :createdAt, :uri,
                :retweetCount, :favoriteCount, :user

  def initialize(tweet)
    if tweet.retweet?
      @retweetUser = TwitterUser.new(tweet.user)
      tweet = tweet.retweeted_status
    end
    _tweet = tweet.attrs
    @id = _tweet[:id_str]
    @text = _tweet[:full_text]
    @createdAt = _tweet[:created_at]
    @retweetCount = _tweet[:retweet_count]
    @favoriteCount = _tweet[:favorite_count]
    @mediaUrls = get_media_urls(tweet)
    @uri = tweet.uri.to_s
    @user = TwitterUser.new(tweet.user)
    if tweet.quote?
      @text.delete!(_tweet[:quoted_status_permalink][:url])
      # client = TwitterApi.client
      @quote = Tweet.new(tweet.quoted_status)
      # @quote = Tweet.new(client.status(_tweet[:quoted_status][:id], tweet_mode: "extended"))
    end
  end

  def get_media_urls(tweet)
    return [] if !tweet.media?
    tweet.media.map { |m| m.media_url_https.to_s + '?name=small' }
  end
end
