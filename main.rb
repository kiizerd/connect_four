# frozen_string_literal: true

Dir[File.join(File.dirname(__FILE__), 'lib', '*.rb')].sort.each do |file|
  require file
end

game = Game.new

test = game.players_moves

puts test