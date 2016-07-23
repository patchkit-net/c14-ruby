require 'net/http'

require_relative 'api_base'

module OnlineNet
  module API
    class Platform < APIBase
      attr_reader :ref
      attr_reader :id

      def initialize(ref, id)
        @ref = ref
        @id = id
      end

      def self.list
        code, list = get("/storage/c14/platform")
        raise "Unexpected return code: #{code}" if code != 200

        list.map do |e|
          Platform.new(e['$ref'], e['id'])
        end
      end
    end
  end
end