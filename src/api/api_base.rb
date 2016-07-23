require 'json'

require_relative '../../config'

module OnlineNet
  module API
    class APIBase
      def self.get(endpoint)
        uri = URI(Config::BASE_URL + endpoint)

        Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
          request = Net::HTTP::Get.new(uri)
          request["Authorization"] = "Bearer #{Config::API_TOKEN}"
          response = http.request(request)

          body = response.body
          if response.code.start_with? "2"
            body = JSON.parse(body)
          end

          [response.code.to_i, body]
        end
      end

      def self.post(endpoint, **params)
        # convert ruby arrays to comma-delimited lists
        params.each do |key, value|
          if value.is_a? Array
            params[key] = value.join(",")
          end
        end

        puts endpoint

        #params[:protocols] = "[\"#{params[:protocols]}\"]"

        puts params

        uri = URI(Config::BASE_URL + endpoint)

        Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
          request = Net::HTTP::Post.new(uri)
          request["Authorization"] = "Bearer #{Config::API_TOKEN}"
          request.form_data = params
          response = http.request(request)

          body = response.body
          if response.code.start_with? "2"
            body = JSON.parse(body)
          end

          [response.code.to_i, body]
        end
      end
    end
  end
end