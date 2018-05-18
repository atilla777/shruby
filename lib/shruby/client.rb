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
      @hosts_file =  options.fetch(
        :input,
        file_path('hosts.txt')
      )
      @results_file = options.fetch(
        :output,
        file_path('shruby_results.txt')
      )
      @hosts = hosts
      @key = options[:key]
      @connection = connection
      @verbose = options.fetch(:verbose, false)
    end

    def run
      result = send_request
      pp result if @verbose
      output result
    end

    private

    def send_request
      @hosts.each_with_object([]) do |host, memo|
        begin
          memo << @connection.rest_api.host(host)
        rescue StandardError => err
          memo << {error: err}
        end
      end
    end

    def output(result)
      File.open(@results_file,'w') do |file|
        file.write result.to_yaml
      end
    end

    def file_path(file_name)
      File.join(File.dirname(Dir.pwd), file_name)
    end

    def connection
      Shodanz.client.new(key: @key)
    end

    def hosts
      @hosts = File.open(@hosts_file, 'r').readlines
    end
  end
end
