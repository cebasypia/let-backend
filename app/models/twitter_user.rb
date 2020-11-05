class TwitterUser
  # プロパティの設定
  attr_accessor :id, :name, :screenName, :description,
                :followersCount, :friendsCount, :profileImageUrl, :uri

  def initialize(user)
    _user = user.attrs
    @id = _user[:id_str]
    @name = _user[:name]
    @screenName = _user[:screen_name]
    @description = _user[:description]
    @followersCount = _user[:followers_count]
    @friendsCount = _user[:friends_count]
    @profileImageUrl = user.profile_image_url_https(size = :bigger).to_s
    @uri = user.uri.to_s
  end
end
