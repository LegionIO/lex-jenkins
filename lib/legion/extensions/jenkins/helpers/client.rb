# frozen_string_literal: true

require 'faraday'

module Legion
  module Extensions
    module Jenkins
      module Helpers
        module Client
          def connection(url: 'http://localhost:8080', username: nil, token: nil, **_opts)
            Faraday.new(url: url) do |conn|
              conn.request :json
              conn.response :json, content_type: /\bjson$/
              conn.headers['Accept'] = 'application/json'
              conn.request :authorization, :basic, username, token if username && token
            end
          end
        end
      end
    end
  end
end
