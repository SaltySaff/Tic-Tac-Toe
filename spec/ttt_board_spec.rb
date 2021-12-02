# frozen_string_literal: true

require_relative '../lib/ttt_board'
require_relative '../lib/ttt_game'
require_relative '../lib/ttt_player'

describe Board do
  subject(:game_board) { described_class.new }

  describe '#modify_board' do
    # command method
    it 'changes the cell value' do
      new_value = 'X'
      game_board.modify_board(1, new_value)
      expect(game_board.cells[0]).to eq('X')
    end
  end

  describe '#someone_won?' do
    context 'when there are three consecutive horizontal crosses' do
      # Only testing for either noughts or crosses in each test, not both,
      # in order to cut down on the total number of tests.
      before do
        game_board.cells[0] = 'X'
        game_board.cells[1] = 'X'
        game_board.cells[2] = 'X'
      end
      it 'returns true' do
        expect(game_board.someone_won?).to be true
      end
    end

    context 'when there are three consecutive vertical noughts' do
      before do
        game_board.cells[0] = 'O'
        game_board.cells[3] = 'O'
        game_board.cells[6] = 'O'
      end
      it 'returns true' do
        expect(game_board.someone_won?).to be true
      end
    end

    context 'when there are three consecutive diagonal crosses' do
      before do
        game_board.cells[0] = 'X'
        game_board.cells[4] = 'X'
        game_board.cells[8] = 'X'
      end
      it 'returns true' do
        expect(game_board.someone_won?).to be true
      end
    end

    context 'when there are no consecutive noughts' do
      before do
        game_board.cells[2] = 'X'
        game_board.cells[3] = 'X'
        game_board.cells[7] = 'X'
      end
      it 'returns false' do
        expect(game_board.someone_won?).to be false
      end
    end
  end

  describe 'check_valid?' do
    context 'when value is valid' do
      it 'returns true' do
        value = 1
        expect(game_board.check_valid?(value)).to be true
      end
    end
    
    context 'when value is invalid' do
      it 'returns false' do
        value = 0
        expect(game_board.check_valid?(value)).to be false
      end
    end
  end

  describe 'board_full?' do
    context 'when board is full' do
      it 'returns true' do
        game_board.cells = game_board.cells.map { |cell| cell = 'X' }
        expect(game_board.board_full?).to be true
      end
    end

    context 'when board is not full' do
      it 'returns false' do
        expect(game_board.board_full?).to be false
      end
    end
  end
end