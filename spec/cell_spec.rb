require './lib/ship.rb'
require './lib/cell.rb'

RSpec.describe Cell do
  before :each do
    coord = "B4"
    @cell = Cell.new(coord)
    @cruiser = Ship.new("Cruiser", 3)
  end

  it 'was created correctly' do
    expect(@cell).to be_instance_of(Cell)
    expect(@cell.coordinates).to eq(coord)
    expect(@cell.ship).to eq(nil)
    expect(@cell.empty?).to eq(true)
    expect(@cell.fired_upon?).to eq(false)
  end
end
