class TwitterApi
  def self.client
    Twitter::REST::Client.new do |config|
      # 事前準備で取得したキーのセット
      config.consumer_key         = Rails.application.credentials.twitter[:CONSUMER_KEY]
      config.consumer_secret      = Rails.application.credentials.twitter[:CONSUMER_SECRET]
      config.access_token         = Rails.application.credentials.twitter[:ACCESS_TOKEN]
      config.access_token_secret  = Rails.application.credentials.twitter[:ACCESS_TOKEN_SECRET]
    end
  end
end
