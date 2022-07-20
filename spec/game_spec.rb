require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

RSpec.describe Game do
  let(:game1) { Game.new }

  it 'computer_fire' do
    game1.computer_fire
    expect(game1.board_player.cells.count { |_key, value| value.fired_upon? == true }).to eq(1)
  end
end
