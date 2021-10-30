require_relative 'game'
require_relative 'player'
require_relative 'user'
require_relative 'dealer'
require_relative 'deck'
require_relative 'card'
require_relative 'hand'

class Interface
  def start
    start = Game.new
    start.greetings
    start.new_round!

    loop do
      start.make_turn
    end
  end
end

Interface.new.start
