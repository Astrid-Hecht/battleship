require './lib/board'

RSpec.describe Board do
  let(:board){Board.new}
  let(:cruiser){Ship.new("Cruiser", 3)}
  let(:submarine){Ship.new("Submarine", 2)}
  let(:battleship){Ship.new("Battleship", 4)}

  it 'can be created' do
    expect(board).to be_instance_of(Board)
  end

  it '#cells' do
    expect(board.cells.keys.count).to eq(16)
    expect(board.cells.values.all?(Cell)).to eq(true)
  end

  describe '#valid_coordinate?(coordinate)' do
    it "returns true if it is a valid coordinate" do
      expect(board.valid_coordinate?("A1")).to eq(true)
    end
    it "returns false if it is not a valid coordinate" do
      expect(board.valid_coordinate?("A22")).to eq(false)
    end
  end
  describe "#valid_placement?(ship, coordinates)" do

    it 'is not valid if the coordinates length is different from the ship length' do
      expect(board.valid_placement?(cruiser, ["A1", "A2"])).to eq(false)
    end

    it "is not valid if the coordinates are not consecutive" do
      expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to eq(false)
    end

    it "is not valid if the coordinates are diagonal" do
      expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to eq(false)
    end

    it "is valid if the coordinates are valid" do
      expect(board.valid_placement?(submarine, ["A1", "A2"])).to eq(true)
      expect(board.valid_placement?(cruiser, ["A1", "A2", "A3"])).to eq(true)
      expect(board.valid_placement?(battleship, ["A1", "A2", "A3", "A4"])).to eq(true)

      expect(board.valid_placement?(submarine, ["A1", "B1"])).to eq(true)
      expect(board.valid_placement?(cruiser, ["A1", "B1", "C1"])).to eq(true)
      expect(board.valid_placement?(battleship, ["A1", "B1", "C1", "D1"])).to eq(true)
    end
  end
end

