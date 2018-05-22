# frozen_string_literal: true

require 'thor'

module Shruby
  class Cli < Thor
    method_option :input, default: 'hosts.txt', desc: 'input file with hosts IP', aliases: '-i'
    method_option :output, default: 'results.txt', desc: 'output file', aliases: '-o'
    method_option :key, desc: 'Shodan API key', aliases: '-k', required: true, type: :string
    method_option :print, desc: 'print result on screen', aliases: '-p', type: :boolean
    method_option :verbose, desc: 'verbose output', aliases: '-v', type: :boolean
    desc(
      'h HOST',
      'Get host info by thier IP'
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
        hosts = host ? [host] : read_hosts(params[:input])
        raise ArgumentError unless hosts
        result.merge(hosts: hosts)
      end

      def print_result(params, result)
        if params.fetch(:output, false) == false || params.fetch(:print, false)
          pp result
        end
      end

      def save_result(params, result)
        return unless params[:output]
        File.open(params[:output],'w') do |file|
          file.write(result.to_yaml)
        end
      end

      def file_path(file_name)
        File.join(File.dirname(Dir.pwd), file_name)
      end

      def read_hosts input
        File.open(input, 'r').readlines
      end
    end
  end
end
