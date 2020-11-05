class Tweet
  # プロパティの設定
  attr_accessor :id, :text, :createdAt, :uri,
                :retweetCount, :favoriteCount, :user

  def initialize(tweet)
    _tweet = tweet.attrs
    @id = _tweet[:id_str]
    @text = _tweet[:full_text]
    @createdAt = _tweet[:created_at]
    @retweetCount = _tweet[:retweet_count]
    @favoriteCount = _tweet[:favorite_count]
    @uri = tweet.uri.to_s
    @user = TwitterUser.new(tweet.user)
  end
end
