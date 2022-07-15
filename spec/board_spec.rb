require './lib/board'

RSpec.describe Board do
  let(:board){Board.new}
  let(:cruiser){Ship.new("Cruiser", 3)}
  let(:submarine){Ship.new("Submarine", 2)}

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
    it "is not valid if the coordinates are diagonal"
    it "is valid if the coordinates are valid"
  end
end
