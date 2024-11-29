# frozen_string_literal: true

require 'aws-xray-sdk'
require_relative 'xray/middleware'
require_relative 'xray/version'

module Faraday
  # This will be your middleware main module, though the actual middleware implementation will go
  # into Faraday::Aws::Xray::Middleware for the correct namespacing.
  module Aws
    module XRay
      # Faraday allows you to register your middleware for easier configuration.
      # This step is totally optional, but it basically allows users to use a
      # custom symbol (in this case, `:xray`), to use your middleware in their connections.
      # After calling this line, the following are both valid ways to set the middleware in a connection:
      # * conn.use Faraday::Aws::Xray::Middleware
      # * conn.use :xray
      # Without this line, only the former method is valid.
      Faraday::Middleware.register_middleware(xray: Faraday::Aws::XRay::Middleware)

      # Alternatively, you can register your middleware under Faraday::Request or Faraday::Response.
      # This will allow to load your middleware using the `request` or `response` methods respectively.
      #
      # Load middleware with conn.request :xray
      # Faraday::Request.register_middleware(xray: Faraday::Aws::Xray::Middleware)
      #
      # Load middleware with conn.response :xray
      # Faraday::Response.register_middleware(xray: Faraday::Aws::Xray::Middleware)
    end
  end
end
