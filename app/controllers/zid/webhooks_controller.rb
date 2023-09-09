class Zid::WebhooksController < ApplicationController
  def create
    request.headers.each {|k, v| p "#{k}:#{v}"}
    head :ok
  end
end