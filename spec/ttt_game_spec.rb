# frozen_string_literal: true

require_relative '../lib/ttt_board'
require_relative '../lib/ttt_game'
require_relative '../lib/ttt_player'

describe Game do
  subject(:example_game) { described_class.new }
  let(:game_board) { instance_double(Board) }
  let(:example_player) { instance_double(Player, name: 'Example Player', choice: 'X') }

  describe '#validate_input' do
    # looping script method
    # will stop when board.check_valid?(number) returns true
    context 'when user input is incorrect once, then correct' do
      before do
        allow(example_game).to receive(:clear_screen)
        allow(game_board).to receive(:display_board)
      end

      it 'completes loop and display error message once' do
        valid_input = 4
        error_message = 'Invalid entry, enter a number from 1-9.'
        expect(example_game).not_to receive(:puts).with(error_message)
        example_game.validate_input(valid_input)
      end
    end

    context 'when user input is incorrect once, then correct' do
      before do
        allow(example_game).to receive(:clear_screen)
        allow(game_board).to receive(:display_board)
        allow(example_game).to receive(:gets).and_return('4')
      end

      it 'completes loop and display error message once' do
        input = 'r'
        error_message = 'Invalid entry, enter a number from 1-9.'
        expect(example_game).to receive(:puts).with(error_message).once
        example_game.validate_input(input)
      end
    end
  end
end
