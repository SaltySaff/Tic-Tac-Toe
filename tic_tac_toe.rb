class Board
  attr_accessor :cells

  def initialize
    @cells = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def create_board
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
    puts "#{player}, please choose the number to place your next #{type}"
    @board_number = gets.chomp.to_i
    if check_valid == false
      request_choice(type, player)
    else
      choose_cell(@board_number, type)
      check_result
    end
  end

  def choose_cell(number, type)
    @cells[number - 1] = type
    create_board
  end

  def check_result
    if @cells[0] == 'X' && @cells[1] == 'X' && @cells[2] == 'X'
      puts 'Player 1 wins!'
      exit
    end
  end
end

class Game < Play
  def play_intro
    puts 'Welcome to Tic-Tac-Toe! Player 1, please choose either O or X'
    goes_first = gets.chomp
    goes_second = goes_first == 'X' ? 'O' : 'X'
    puts "Player 2, you will be #{goes_second} for this game."
    create_board
    play_game(goes_first, goes_second)
  end

  def play_game(first, second)
    4.times do
      request_choice(first, 'Player 1')
      request_choice(second, 'Player 2')
    end
  end
end

game = Game.new
game.play_intro



# winning combinations (horizontal): (0, 1, 2), (3, 4, 5), (6, 7, 8)
# winning combinations (vertical):   (0, 3, 6), (1, 4, 7), (2, 5, 8)
# winning combinations (diagonal):   (0, 4, 8), (2, 4, 6)