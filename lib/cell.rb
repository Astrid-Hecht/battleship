require './lib/ship.rb'

class Cell
  attr_reader :coordinates, :ship, :empty?, :fired_upon?
  def initialize(coord)
    @coordinates = coord
    @ship = nil
    @empty? = true
    @fired_upon? = false
  end
end
