# frozen_string_literal: true

require 'thor'
require 'pp'

module Shruby
  class Cli < Thor
    method_option :input, desc: 'input file with hosts IP', aliases: '-i'
    method_option :output, desc: 'output file', aliases: '-o'
    method_option :key, desc: 'Shodan API key', aliases: '-k', required: true, type: :string
    method_option :print, desc: 'print result on screen', aliases: '-p', type: :boolean
    method_option :history, desc: 'get full history of an IP address', aliases: '-h', type: :boolean
    method_option :minify, desc: 'not show banners', aliases: '-m', type: :boolean
    # TODO: use or delete
    # method_option :verbose, desc: 'verbose output', aliases: '-v', type: :boolean
    desc(
      'h HOST',
      'Get host/hosts info by IP'
    )
    def h(host = nil)
      params = set_params(host, options)
      result = Shruby::Client.new(params).request
      print_result(params, result)
      save_result(params, result)
    end

    private

    no_commands do
      def set_params(host, params)
        result = params
        check_hosts_params(host, params)
        hosts = host ? [host] : read_hosts(params[:input])
        result.merge(hosts: hosts)
      end

      def print_result(params, result)
        if params.fetch(:output, false) == false || params.fetch(:print, false)
          pp result
        end
      end

      def save_result(params, result)
        return unless params[:output]
        check_file_error do
          File.open(params[:output],'w') do |file|
            file.write(result.to_yaml)
          end
        end
      end

      def file_path(file_name)
        File.join(Dir.pwd, file_name)
      end

      def read_hosts input
        check_file_error { File.open(input, 'r').readlines }
      end

      def check_hosts_params(hosts, params)
        return if hosts || params[:input]
        raise ArgumentError.new("Host or hosts file must be specified")
      end

      def check_file_error
        begin
          yield
        rescue StandardError => e
          puts "Error open file: #{e}"
        end
      end
    end
  end
end
