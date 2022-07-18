require './lib/ship'
require './lib/cell'
require 'pry'

RSpec.describe Cell do
  before :each do
    @coord = "B4"
    @cell = Cell.new(@coord)
    @cruiser = Ship.new("Cruiser", 3)
  end

  it 'was created correctly' do
    expect(@cell).to be_instance_of(Cell)
    expect(@cell.coordinates).to eq(@coord)
    expect(@cell.ship).to eq(nil)
    expect(@cell.empty?).to eq(true)
    expect(@cell.fired_upon?).to eq(false)
  end

  it 'can place a ship' do
    @cell.place_ship(@cruiser)
    expect(@cell.empty?).to eq(false)
    expect(@cell.ship).to be_an_instance_of(Ship)
    expect(@cell.ship).to eq(@cruiser)
  end

  it 'can detect if fired upon' do
    @cell.place_ship(@cruiser)
    expect(@cell.fired_upon?).to eq(false)
    @cell.fire_upon
    expect(@cell.ship.health).to eq(2)
    expect(@cell.fired_upon?).to eq(true)
  end

  it 'can render cell symbols correctly' do
    expect(@cell.render).to eq(".")
    @cell.fire_upon
    expect(@cell.render).to eq("M")
    cell_w_ship = Cell.new("C3")
    cell_w_ship.place_ship(@cruiser)
    expect(cell_w_ship.render).to eq(".")
    expect(cell_w_ship.render(true)).to eq("S")
    cell_w_ship.fire_upon
    expect(cell_w_ship.render).to eq("H")
    expect(@cruiser.sunk?).to eq(false)
    2.times {@cruiser.hit}
    expect(@cruiser.sunk?).to eq(true)
    expect(cell_w_ship.render).to eq("X")
  end
end

