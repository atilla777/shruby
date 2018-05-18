# frozen_string_literal: true

require 'thor'

module Shruby
  class Cli < Thor
    option :input, aliases: '-i'
    option :output, aliases: '-o'
    option :key, aliases: '-k'
    option :verbose, aliases: '-v'
    desc 'hosts -i <hosts file> -o <result file>', 'Get hosts info by thier IP'
    def hosts
      Shruby::Client.new(
        options[:input],
        options[:output],
        options[:key],
        options[:verbose]
      ).run
    end
  end
end
