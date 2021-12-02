# frozen_string_literal: true

# creates and modifies players
class Player
  attr_accessor :name, :choice

  def initialize(name)
    @name = name
    @choice = ''
  end

  def create_player
    puts "#{@name}, please enter your name."
    @name = gets.chomp
  end

  def player_selection
    until @choice == 'X' || @choice == 'O'
      puts "#{@name} would you like to be noughts, or crosses? (X/O)"
      @choice = gets.chomp.upcase
    end
  end
end
