# frozen_string_literal: true

require 'shodanz'
require 'yaml'

module Shruby
  # ==Represent client for connect to Shodan service
  class Client
    # ==Create new connection to Shodan service
    # ===Argumnets:
    #   *input - file with hosts IP
    #   *output - file for result
    #   *key - Shodan API KEY
    #
    # ===Examples:
    #   >>Shruby::Client.new(
    #     input: './hosts.txt',
    #     output: './results.txt',
    #     key: 'Shodan API KEY',
    #     verbose: true
    #     )
    #
    def initialize(options)
      @hosts = options[:hosts]
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
  end
end
