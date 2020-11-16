class User < ApplicationRecord
  has_one_attached :avatar

  def self.from_token_payload(payload)
    user = find_by(id: payload['sub'])
    return user if user

    auth0_user = fetch_user(payload['sub'])
    create!(id: payload['sub'], name: auth0_user["nickname"], profileImageUrl: auth0_user["picture"])
  end

  def self.access_token
    require 'uri'
    require 'net/http'

    url = URI("https://auth0-sample-cebasypia.us.auth0.com/oauth/token")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(url)
    request["content-type"] = 'application/json'
    request.body = "{\"client_id\":\"uF8gxL8frXB9aeQTZ77DNbThC4xS4yga\",\"client_secret\":\"3vvJoLMF7wlK5BSJbuX8G1tOYyd46bgFWHR7Pa477YzNtaVgmL98jNCX3nmc44dV\",\"audience\":\"https://auth0-sample-cebasypia.us.auth0.com/api/v2/\",\"grant_type\":\"client_credentials\"}"

    response = http.request(request)
    data = response.read_body
    hash = JSON.parse(data)
    hash["access_token"]
  end

  def self.fetch_user(id)
    require 'uri'
    require 'net/http'

    encoded_url = URI.encode("https://auth0-sample-cebasypia.us.auth0.com/api/v2/users/#{id}")
    url = URI.parse(encoded_url)

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["authorization"] = "Bearer #{access_token}"

    response = http.request(request)
    data = response.read_body
    JSON.parse(data)
  end
end
