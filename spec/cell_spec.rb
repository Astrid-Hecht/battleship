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

  it 'knows when it was fired upon' do

    @cell.place_ship(cruiser)

    expect(@cell.fired_upon?).to eq(false)

    @cell.fire_upon

    expect(@cell.ship.health).to eq(2)
    expect(@cell.fired_upon?).to eq(true)
  end

  it 'can render cells' do
    @cell_1 = Cell.new("B4")
    @cell_2 = Cell.new("C3")

    expect(@cell_1).to be_instance_of(Cell)
    expect(@cell_2).to be_instance_of(Cell)
    expect(@cell_1.render).to eq(".")
    expect(@cell_2.render).to eq(".")

    @cell_1.fire_upon
    expect(@cell_1.render).to eq("M")

    @cell_2.place_ship(cruiser)
    expect(@cell_2.render(true)).to eq("S")

    @cell_2.fire_upon
    expect(@cell_2.render).to eq("H")
    expect(@cruiser.sunk?).to eq("false")

    @cruiser.hit
    @cruiser.hit
    expect(@cruiser.sunk?).to eq("true")
    expect(@cell_2.render).to eq("X")
  end
end
