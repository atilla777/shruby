# frozen_string_literal: true

require 'shodanz'
require 'yaml'

module Shruby
  # Get info about hosts from Shodan service
  # Example:
  # shruby hosts -i hosts.txt -o results.txt -k API_KEY
  # where hosts is file with list of IPs:
  # 10.1.1
  # 192.168.1.2
  # etc.
  class Client
    def initialize(input_file = nil, output_file = nil, key = nil, verbose = false)
      @hosts_file =  input_file || file_path('hosts.txt')
      @results_file = output_file || file_path('shruby_results.txt')
      @hosts = hosts
      @key = key
      @client = client
      @verbose = verbose
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
          memo << @client.rest_api.host(host)
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

    def client
      Shodanz.client.new(key: @key)
    end

    def hosts
      @hosts = File.open(@hosts_file, 'r').readlines
    end
  end
end
