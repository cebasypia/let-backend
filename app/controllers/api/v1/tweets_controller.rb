class Api::V1::TweetsController < ActionController::API
  before_action :set_client

  def search
    @tweets = []
    since_id = nil
    count = (params[:count] || 15).to_i
    max_id = params[:max_id] || 0
    # リツイートを除く、検索ワードにひっかかった最新10件のツイートを取得する
    tweets = @client.search(
      "#{params[:word]}#{params[:from]}",
      lang: params[:lang],
      tweet_mode: "extended",
      count: 10,
      result_type: params[:result_type],
      exclude: "retweets",
      since_id: since_id,
      max_id: max_id.to_i - 1
    )
    tweets.take(count).each do |tweet|
      @tweet = Tweet.new(tweet)
      @tweets.push(@tweet)
    end
    render json: @tweets.sort_by { |tweet| tweet.id }.reverse
  end

  def show
    tweet = @client.status(params[:id], tweet_mode: "extended")
    @tweet = Tweet.new(tweet)
    render json: @tweet
  end

  def user
    user = @client.user(params[:screen_name])
    @user = TwitterUser.new(user)
    render json: @user
  end

  private

  def set_client
    @client = TwitterApi.client
  end
end
