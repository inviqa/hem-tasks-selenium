require 'net/http'

module Hem
  class Url
    def self.exists(url)
      url = URI.parse(url)
      Net::HTTP.start(url.host, url.port) do |http|
        return http.head(url.request_uri).code == '200'
      end
    end
  end
end