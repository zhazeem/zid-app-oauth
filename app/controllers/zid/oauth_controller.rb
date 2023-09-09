class Zid::OauthController < ApplicationController
  def redirect
    redirect_to "#{base_url}/oauth/authorize?client_id=#{client_id}&response_type=code", allow_other_host: true
  end

  def callback
    payload = {
      grant_type: 'authorization_code',
      client_id:,
      client_secret:,
      code: params[:code],
    }

    puts "----"
    p faraday_client.post('/oauth/token', payload).body
    request.headers.each {|k, v| p "#{k}:#{v}"}
    puts "----"

    redirect_to root_path
  end

  private

  def client_id
    2487
  end

  def client_secret
    'FILL ME'
  end

  def base_url
    'https://oauth.zid.sa'
  end

  def faraday_client
    @faraday_client ||= Faraday.new(base_url) do |builder|
      # We should raise errors when something does not go as expected.
      builder.use Faraday::Response::RaiseError

      # Log the response when configured, and parse the response as JSON.
      builder.response :logger, Rails.logger, headers: false

      # We're dealing with json.
      builder.request :json
      builder.response :json

      # Use the default adapter (net_http) for the http calls.
      builder.adapter Faraday.default_adapter
    end
  end
end