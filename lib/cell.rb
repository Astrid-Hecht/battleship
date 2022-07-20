require './lib/ship'
require './lib/graphics'

class Cell
  attr_reader :coordinates, :ship, :empty, :fired_upon

  def initialize(coord)
    @coordinates = coord
    @ship = nil
    @empty = true
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

  def fire_upon
    @fired_upon = true
    if @empty == false
      @ship.hit
      @graphics_cell.hit_anim(self.ship.name)
    else
      @graphics_cell.miss_anim
    end
    @graphics_cell.sunk_anim(@ship.name) if @empty == false && @ship.sunk?
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
    else
      abort('somethings wrong')
    end
  end
end
