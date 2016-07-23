require 'net/http'

require_relative 'api_base'

module OnlineNet
  module API
    class Archive < APIBase
      def self.create(safe, name, description, protocols, ssh_keys, platforms)
        post(
          "/storage/c14/safe/#{safe.uuid_ref}/archive",
          name: name,
          description: description,
          protocols: protocols,
          ssh_keys: ssh_keys,
          platforms: platforms.map { |p| p.id}
          )
      end
    end
  end
end