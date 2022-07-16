require './lib/board'


RSpec.describe Board do
  let(:board){Board.new}
  let(:cruiser){Ship.new("Cruiser", 3)}
  let(:submarine){Ship.new("Submarine", 2)}
  let(:destroyer){Ship.new("Destroyer", 4)}

  it 'can be created' do
    expect(board).to be_instance_of(Board)
  end

  it '#cells' do
    expect(board.cells.keys.count).to eq(16)
    expect(board.cells.values.all?(Cell)).to eq(true)
  end

  describe '#valid_coordinate?(coordinate)' do
    it 'returns true if it is a valid coordinate' do
      expect(board.valid_coordinate?("A1")).to eq(true)
    end
    it 'returns false if it is not a valid coordinate' do
      expect(board.valid_coordinate?("A22")).to eq(false)
    end
  end
  describe '#valid_placement?(ship, coordinates)' do

    it 'is not valid if the coordinates length is different from the ship length' do
      expect(board.valid_placement?(cruiser, ["A1", "A2"])).to eq(false)
      expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to eq(false)
    end

    it 'is not valid if the coordinates are not consecutive' do
      expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to eq(false)
      expect(board.valid_placement?(submarine, ["A1", "C1"]))
      expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to eq(false)
      expect(board.valid_placement?(submarine, ["C1", "B1"])).to eq(false)
    end

    it 'is not valid if the coordinates are diagonal' do
      expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to eq(false)
      expect(board.valid_placement?(submarine, ["C2", "D3"])).to eq(false)
    end

    it 'is valid if the coordinates are valid' do
      expect(board.valid_placement?(submarine, ["A1", "A2"])).to eq(true)
      expect(board.valid_placement?(cruiser, ["A1", "A2", "A3"])).to eq(true)
      expect(board.valid_placement?(destroyer, ["A1", "A2", "A3", "A4"])).to eq(true)

      expect(board.valid_placement?(submarine, ["A1", "B1"])).to eq(true)
      expect(board.valid_placement?(cruiser, ["A1", "B1", "C1"])).to eq(true)
      expect(board.valid_placement?(destroyer, ["A1", "B1", "C1", "D1"])).to eq(true)
    end
  end

  describe '#place' do
    it 'places ship at valid coordinates' do
      board.place(cruiser, ["A1", "A2", "A3"])
      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]
      cell_3 = board.cells["A3"]
      expect(cell_1.ship).to eq(cruiser)
      expect(cell_1.ship).to eq(cruiser)
      expect(cell_1.ship).to eq(cruiser)
      expect(cell_3.ship == cell_2.ship).to eq(true)
    end

    it "doesn't place at invalid coordinates" do
      expect(board.place(cruiser, ["A1", "A2"])).to eq(nil)
      expect(board.place(cruiser, ["A1", "A2", "A4"])).to eq(nil)
      expect(board.place(cruiser, ["A3", "B2", "C1"])).to eq(nil)
    end

    it 'prevents overlapping placement' do
      board.place(cruiser, ["A1", "A2", "A3"])
      expect(board.valid_placement?(submarine, ["A1", "B1"])).to eq(false)
    end
  end
end

