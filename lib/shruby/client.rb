# frozen_string_literal: true

require 'shodanz'
require 'yaml'

module Shruby
  # ===Represent client for connect to Shodan service
  class Client
    def initialize(options)
      @hosts = options[:hosts]
      check_hosts_params(@hosts)
      @key = options[:key]
      @connection = connection
    end

    def request
      @hosts.each_with_object([]) do |host, memo|
        begin
          memo << @connection.rest_api.host(host)
        rescue StandardError => err
          memo << {error: err}
        end
      end
    end

    private

    def connection
      Shodanz.client.new(key: @key)
    end

    def check_hosts_params(hosts)
      return if hosts.any?
      raise ArgumentError.new("Host or hosts must be specified")
    end
  end
end
