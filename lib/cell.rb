require './lib/ship'
require './lib/graphics'

class Cell
  attr_reader :coordinates, :ship, :empty, :fired_upon

  def initialize(coord, empty=true)
    @coordinates = coord
    @ship = nil
    @empty = empty
    @fired_upon = false
    @graphics_cell = Graphics.new
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

  def fire_upon(anim = true)
    @fired_upon = true
    if anim == false
      if @empty == false
        @ship.hit
      end
    elsif anim == true
      if @empty == false
        @ship.hit
        @graphics_cell.hit_anim(self.ship.name)
      else
        @graphics_cell.miss_anim
      end
      @graphics_cell.sunk_anim if @empty == false && @ship.sunk?
    end
  end

  def render(show = false)
    if @empty == true && @fired_upon == false
      '.'
    elsif @empty == true && @fired_upon == true
      'M'
    elsif @empty == false && @fired_upon == true && @ship.health <= 0
      'X'
    elsif @empty == false && @fired_upon == true
      'H'
    elsif show == false && @empty == false
      '.'
    elsif show == true && @empty == false
      'S'
    end
  end
end
