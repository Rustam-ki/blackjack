class Game
  attr_reader :current_player

  def initialize
    @user = User.new
    @dealer = Dealer.new
    @deck = nil
    @bank = 0
    @current_player = nil
    @interface = Interface.new(@user, @dealer)
    @finish_round = nil
  end

  def start(start)
    @start = start
    greetings
    new_round!

    loop do
      make_turn
    end
  end

  def make_turn
    action = current_player.choose_action

    @interface.turn_make(action, current_player)
  end

  def new_round!
    @deck = Deck.new
    @interface.new_round(@start)
    @current_player = @user
  end

  def ask_for_more
    @interface.ask_more(@start)
  end

  def choose_winner
    show_both_hands

    if (@user.points > 21 && @dealer.points > 21) || @user.points == @dealer.points
      user_draw
    elsif @user.points > 21
      user_lost
    elsif @dealer.points > 21 || @user.points > @dealer.points
      user_win
    else
      user_lost
    end

    @bank = 0
    ask_for_more
  end

  def user_win
    @interface.win_user(@bank)
  end

  def user_lost
    @interface.lost_user(@bank)
  end

  def user_draw
    @interface.draw_user(@bank)
  end

  def check_three_cards!
    @finish_round = (@user.hand.size == 3 && @dealer.hand.size == 3)
  end

  def greetings
    @interface.started
  end

  def take_card(player)
    @interface.card_take(player, @deck)

    skip_turn
  end

  def give_two_cards(player)
    2.times { player.draw_card(@deck) }
  end

  def make_bets(amount)
    @user.take_money(amount)
    @dealer.take_money(amount)

    @bank += (amount * 2)
  end

  def skip_turn
    @interface.turn_skip
  end

  def show_both_hands
    @interface.show_hands
  end

  def change_player
    @current_player = (@current_player == @user ? @dealer : @user)
  end
end
