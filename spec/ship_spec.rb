require './lib/ship'

RSpec.describe Ship do
  before :each do
    @give_name = 'Cruiser'
    @give_length = 3
    @cruiser = Ship.new(@give_name, @give_length)
  end

  it 'creates Ship correctly' do
    expect(@cruiser).to be_an_instance_of(Ship)
    expect(@cruiser.name).to eq(@give_name)
    expect(@cruiser.length).to eq(@give_length)
    expect(@cruiser.health).to eq(@give_length)
    expect(@cruiser.sunk?).to eq(false)
  end

  it 'takes a hit and checks if sunk' do
    start_health = @cruiser.health
    3.times do |shot|
      @cruiser.hit
      expect(@cruiser.health).to eq(start_health - (1 + shot))
      if shot >= 2
        expect(@cruiser.sunk?).to eq(true)
      else
        expect(@cruiser.sunk?).to eq(false)
      end
    end
  end
end
