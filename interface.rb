class Interface
  def initialize(user, dealer)
    @dealer = dealer
    @user = user
  end

  def started

    puts 'Приветствуем! Как вас зовут?'
    @user.name = gets.chomp
  end

  def turn_make(action, current_player)
    @current_player = current_player

    case action
    when 1 then @start.skip_turn
    when 2 then @start.take_card(@current_player)
    when 3 then @finish_round = true
    else puts 'Wrong command'
    end
    @start.choose_winner if @finish_round || @start.check_three_cards!
  end

  def new_round(start)
    @start = start
    @finish_round = false
    @user.refresh!
    @dealer.refresh!

    puts '===================', 'LET THE GAME BEGIN!', 'Giving you 2 cards:'
    @start.give_two_cards(@user)
    @user.show_cards

    puts 'Giving dealer 2 cards:'
    @start.give_two_cards(@dealer)
    puts '**'

    @start.make_bets(10)

  end

  def ask_more(start)
    @start = start
    puts 'Wanna more? <Y>'
    @act = gets.chomp.upcase
    action = @act

    if action == 'Y'
      @start.new_round!
    else
      puts 'Всего хорошего, и спасибо за рыбу!'
      exit!
    end
  end

  def win_user(bank)
    puts 'You win!'
    @user.give_money(bank)
  end

  def lost_user(bank)
    puts 'You lost!'
    @dealer.give_money(bank)
  end

  def card_take(player, deck)
    puts 'Drawing a card...'
    player.draw_card(deck)
    sleep(1)

    if player.is_a?(User)
      puts "#{player.class}, now your hand:"
      @user.show_cards
    end
  end

  def show_hands
    puts 'User:'
    @user.show_cards

    puts 'Dealer:'
    @dealer.show_cards
  end

  def draw_user(bank)
    puts "It's draw!"
    @user.give_money(bank / 2)
    @dealer.give_money(bank / 2)
  end

  def turn_skip
    @start.change_player
    sleep(1)
    puts "Now its #{@current_player.class} turn."
  end

end