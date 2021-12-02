# frozen_string_literal: true

# controls the tic-tac-toe board, including editing it and checking for victory
class Board
  attr_reader :cells

  COMBINATIONS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]].freeze

  def initialize
    @cells = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def display_board
    puts '-------------'
    puts "| #{cells[0]} | #{cells[1]} | #{cells[2]} |"
    puts '-------------'
    puts "| #{cells[3]} | #{cells[4]} | #{cells[5]} |"
    puts '-------------'
    puts "| #{cells[6]} | #{cells[7]} | #{cells[8]} |"
    puts '-------------'
  end

  def modify_board(element, value)
    @cells[element - 1] = value
  end

  def someone_won?
    all_x = COMBINATIONS.any? { |combo| combo.all? { |index| @cells[index - 1] == 'X' } }
    all_o = COMBINATIONS.any? { |combo| combo.all? { |index| @cells[index - 1] == 'O' } }
    all_o || all_x == true ? true : false
  end

  def check_valid?(value)
    (1..9).include?(value.to_i)
  end

  def board_full?
    @cells.all? { |elements| elements == "X" || elements == "O" }
  end
end
