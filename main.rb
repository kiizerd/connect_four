# frozen_string_literal: true

require 'pry'

Dir[File.join(File.dirname(__FILE__), 'lib', '*.rb')].sort.each do |file|
  require file
end

game = Game.new

binding.pry
