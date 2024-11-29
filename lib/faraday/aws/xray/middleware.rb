# frozen_string_literal: true

module Faraday
  module Aws
    module XRay
      class Middleware < Faraday::Middleware
        def initialize(app, options = {})
          super(app)
          @name = options[:name] || 'external_http_request'
        end

        def call(env)
          ::XRay.recorder.capture(@name) do |_segment|
            ::XRay.recorder.capture(env.url.to_s) do |subsegment|
              add_request_data(subsegment, env)

              response = @app.call(env)

              add_response_data(subsegment, response)
              response
            end
          end
        end

        private

        def add_request_data(subsegment, env)
          subsegment.merge_http_request(
            request: {
              method: env.method.to_s.upcase,
              url: env.url.to_s,
              user_agent: env.request_headers['User-Agent']
            }
          )
        end

        def add_response_data(subsegment, response)
          subsegment.merge_http_response(
            response: {
              status: response.status,
              content_length: response.headers['Content-Length']
            }
          )
        end
      end
    end
  end
end
