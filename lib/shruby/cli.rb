# frozen_string_literal: true

require 'thor'

module Shruby
  class Cli < Thor
    option :input, aliases: '-i'
    option :output, aliases: '-o'
    option :key, aliases: '-k'
    option :verbose, aliases: '-v'
    desc(
      'hosts -i <HOST FILE> -o <RESULT FILE> -k <API KEY> [-v]',
      'Get hosts info by thier IP'
    )
    def hosts
      Shruby::Client.new(options).run
    end
  end
end
