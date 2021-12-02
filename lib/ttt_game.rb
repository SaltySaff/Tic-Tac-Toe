# frozen_string_literal: true

class Game
  def initialize
    @board = Board.new
    @player_one = Player.new('Player One')
    @player_two = Player.new('Player Two')
    @active_player = @player_one
  end

  def reset
    @board = Board.new
    clear_screen
    start_game
  end

  def start_game
    puts 'Welcome to Tic-Tac-Toe!'
    player_setup
    play_game
  end

  def play_game
    @board.display_board
    request_input(@active_player)
    play_game
  end

  def player_setup
    @player_one.create_player
    @player_two.create_player
    clear_screen
    @player_one.player_selection
    clear_screen
    @player_two.choice = @player_one.choice == 'O' ? 'X' : 'O'
    puts "#{@player_one.name} is #{@player_one.choice}, #{@player_two.name} is #{@player_two.choice}."
  end

  def request_input(player)
    puts "Where would you like to place your #{@active_player.choice}, #{@active_player.name}?"
    number = gets.chomp.to_i
    validate_input(number)
    @board.modify_board(number, @active_player.choice)
    check_for_victory(player)
    clear_screen
    @active_player = @active_player == @player_one ? @player_two : @player_one
  end

  def validate_input(number)
    until @board.check_valid?(number)
      clear_screen
      @board.display_board
      puts 'Invalid entry, enter a number from 1-9.'
      number = gets.chomp.to_i
    end
    @board.modify_board(number, @active_player.choice)
  end

  def check_for_victory(player)
    if @board.someone_won?
      game_end(player, 'victory')
    elsif @board.board_full?
      game_end(player, 'draw')
    end
  end

  def game_end(player, result)
    case result
    when 'victory'
      clear_screen
      puts "#{player.name} wins! Congratulations!"
      play_again?
    when 'draw'
      clear_screen
      puts "Looks like it's a draw!"
      play_again?
    end
  end

  def play_again?
    @board.display_board
    puts 'Would you like to play again? (Y/N)'
    choice = gets.chomp.upcase
    case choice
    when 'Y' then reset
    when 'N' then exit
    else play_again?
    end
  end

  def clear_screen
    system 'clear'
  end
end