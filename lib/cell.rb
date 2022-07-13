require './lib/ship.rb'

class Cell
  attr_reader :coordinates, :ship, :empty, :fired_upon
  def initialize(coord)
    @coordinates = coord
    @ship = nil
    @empty = true
    @fired_upon = false
  end

  def empty?
    @empty
  end

  def fired_upon?
    @fired_upon
  end

  def place_ship(type)
    @ship = type
    @empty = false
  end

  def fire_upon
    @fired_upon = true
      if @empty == false
        @ship.hit
      end
  end

  def render(show = false)
    if @empty == true && @fired_upon == false
      "."
    elsif @empty == true && @fired_upon == true
      "M"
    elsif @empty == false && @fired_upon == true && @ship.health <= 0
      "X"
    elsif @empty == false && @fired_upon == true
      "H"
    elsif @show == true && @empty == false
      "S"
    else
      abort("render error")
    end
  end
end
