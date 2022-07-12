require './lib/ship.rb'

RSpec.describe Ship do
  before :each do
    @cruiser = Ship.new("Cruiser", 3)
  end

  it 'was created correctly' do
    expect(cruiser).to be_an_instance_of(Ship)
    expect(cruiser.name).to eq("Cruiser")
    expect(cruiser.length).to eq(3)
    expect(cruiser.health).to eq(3)
    expect(cruiser.sunk?).to eq(false)
  end
end
