require 'net/http'

require_relative 'api_base'

module OnlineNet
  module API
    class Safe < APIBase
      attr_reader :ref
      attr_reader :uuid_ref
      attr_reader :name
      attr_reader :status

      def initialize(ref, uuid_ref, name, status)
        @ref = ref
        @uuid_ref = uuid_ref
        @name = name
        @status = status
      end

      def self.list
        code, list = get("/storage/c14/safe")
        raise "Unexpected return code: #{code}" if code != 200

        list.map do |e|
          Safe.new(e['$ref'], e['uuid_ref'], e['name'], e['status'])
        end
      end

    end
  end
end