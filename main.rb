require_relative 'game'
require_relative 'interface'
require_relative 'player'
require_relative 'user'
require_relative 'dealer'
require_relative 'deck'
require_relative 'card'
require_relative 'hand'

=begin
Game.new.start
=end
@start = Game.new
@start.start(@start)

