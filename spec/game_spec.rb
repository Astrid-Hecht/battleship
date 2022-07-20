require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

RSpec.describe Game do
  let(:game1) { Game.new }
  describe '#initialization' do
    it 'exists' do
      expect(game1).to be_an_instance_of(Game)
    end
    it 'has boards' do
      expect(game1.board_player).to be_an_instance_of(Board)
      expect(game1.board_computer).to be_an_instance_of(Board)
    end
    it 'has matching ship set' do
      expect(game1.player_ships).to be_a(Array)
      expect(game1.player_ships[0]).to be_an_instance_of(Ship)
      expect(game1.player_ships[0].name).to eq(game1.computer_ships[0].name)
      expect(game1.player_ships[0].length).to eq(game1.computer_ships[0].length)
      expect(game1.player_ships[1].name).to eq(game1.computer_ships[1].name)
      expect(game1.player_ships[1].length).to eq(game1.computer_ships[1].length)
    end
  end

  describe '#play' do
    it 'computer can place' do
      game1.computer_place
      placed_ships = []
      cells_w_ship = game1.board_computer.cells.select{|_key, cells| cells.empty? == false}
      expect(cells_w_ship.count).to eq(5) # cruiser length (3) + sub length (2)
      cells_w_ship.each_value { |cell| placed_ships << cell.ship.name }
      expect(placed_ships.uniq.sort).to eq(["Cruiser", "Submarine"])
    end

    it 'computer can shoot' do
      game1.computer_fire(false)
      expect(game1.board_player.cells.count { |_key, value| value.fired_upon? == true }).to eq(1)
    end

    it 'player can win' do
      game1.computer_place
      cells_w_ship = game1.board_computer.cells.select{|_key, cells| cells.empty? == false}
      cells_w_ship.each_value {|cell| cell.fire_upon(false)}
      expect(game1.end_game).to eq('You won!')
    end

    it 'computer can win' do
      game1.board_player.place(game1.player_ships[0], ["A1", "B1", "C1"])
      game1.board_player.place(game1.player_ships[1], ["A2", "B2"])
      cells_w_ship = game1.board_player.cells.select{|_key, cells| cells.empty? == false}
      cells_w_ship.each_value {|cell| cell.fire_upon(false)}
      expect(game1.end_game).to eq('I won!')
    end
  end
end
