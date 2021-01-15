class Board
  COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]].freeze
  attr_accessor :cells

  def initialize
    @cells = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def create_board
    sleep(0.25)
    puts '-------------'
    puts "| #{@cells[0]} | #{@cells[1]} | #{@cells[2]} |"
    puts '-------------'
    puts "| #{@cells[3]} | #{@cells[4]} | #{@cells[5]} |"
    puts '-------------'
    puts "| #{@cells[6]} | #{@cells[7]} | #{@cells[8]} |"
    puts '-------------'
  end
end

class Play < Board
  def initialize
    super
    @board_number = 0
  end

  def check_valid
    sleep(0.5)
    if @cells[@board_number - 1] == 'X' || @cells[@board_number - 1] == 'O'
      puts 'This cell has already been chosen, please choose an available cell.'
      false
    elsif @board_number > 9 || @board_number < 1
      puts 'Please choose a number between 1 and 9.'
      false
    else
      true
    end
  end

  def request_choice(type, player)
    sleep(0.25)
    puts "#{player}, please choose a number to place your next #{type}."
    @board_number = gets.chomp.to_i
    if check_valid == false
      sleep(0.5)
      request_choice(type, player)
    else
      choose_cell(@board_number, type)
      check_result(player)
    end
  end

  def choose_cell(number, type)
    @cells[number - 1] = type
    create_board
  end

  def check_result(player)
    all_x = COMBINATIONS.any? { |i| i.all? { |number| @cells[number] == 'X' }}
    all_o = COMBINATIONS.any? { |i| i.all? { |number| @cells[number] == 'O' }}
    if all_x == true || all_o == true
      puts "#{player} wins!"
      play_again
    end
  end
end

class Game < Play
  def play_intro
    sleep(0.2)
    @cells = [1, 2, 3, 4, 5, 6, 7, 8, 9] # reintialize cells for a new game
    puts 'Welcome to Tic-Tac-Toe!'
    sleep(1)
    decide_players
  end

  def play_again
    puts 'Would you like to play again? (Y/N)'
    yes_or_no = gets.chomp
    case yes_or_no
    when 'Y', 'y' then play_intro
    when 'N', 'n' then exit
    else play_again_invalid
    end
  end

  def play_again_invalid
    puts 'Please enter either Y or N.'
    play_again
  end

  def x_or_o_invalid(choice)
    unless choice == 'O' || choice == 'X'
      puts 'Please enter either O or X.'
      decide_players
    end
  end

  def decide_players
    puts 'Player 1, please choose either O or X.'
    goes_first = gets.chomp
    x_or_o_invalid(goes_first)
    goes_second = goes_first == 'X' ? 'O' : 'X'
    sleep(0.5)
    puts "Player 2, you will be #{goes_second} for this game."
    create_board
    play_game(goes_first, goes_second)
  end

  def play_game(first, second)
    5.times do
      request_choice(first, 'Player 1')
      if @cells.any? { |number| (1..9).include?(number) } == true # keep on playing until @cells contains no numbers
        request_choice(second, 'Player 2')
      end
    end
    puts "It's a draw!"
    play_again
  end
end

game = Game.new
game.play_intro

# winning combinations (horizontal): (0, 1, 2), (3, 4, 5), (6, 7, 8)
# winning combinations (vertical):   (0, 3, 6), (1, 4, 7), (2, 5, 8)
# winning combinations (diagonal):   (0, 4, 8), (2, 4, 6)

# NOTE: look into play_again, and how the game calculates a draw
