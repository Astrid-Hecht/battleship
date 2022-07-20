require './lib/cell'

class Board

  attr_reader :cells
  attr_accessor :ships, :side_size
  
  def initialize(size = 4, ship_set = 'default')
    @side_size = size
    coord_y = (("A".."Z").to_a)[0..(@side_size-1)]
    grid_coords = []

    coord_y.each do |letter|
      num = 0
      @side_size.times do
        num += 1
        grid_coords << letter + num.to_s
      end
    end

    @cells = {}
    grid_coords.each do |coord|
      @cells.store(coord, Cell.new(coord))
    end

    if ship_set == 'default'
      @ships = [
        @cruiser = Ship.new('Cruiser', 3),
        @submarine = Ship.new('Submarine', 2)
      ]
    else
      @ships = ship_set
    end
  end

  def valid_coordinate?(coordinate)
    @cells.has_key?(coordinate)
  end

  def coords_linear?
    (@alph_array.uniq.count == 1 || @alph_array == ((@alph_array[0])..(@alph_array[-1])).to_a) &&
      (@num_array.uniq.count == 1 || @num_array == ((@num_array[0])..(@num_array[-1])).to_a) &&
      (@alph_array.uniq.count == 1 || @num_array.uniq.count == 1)
  end

  def overlap?(coordinates)
    coordinates.each do |coord|
      if @cells[coord].empty? == false
        return true
      end
    end
    false
  end

  def valid_placement?(ship, coordinates)
    if ship.length == coordinates.uniq.count && overlap?(coordinates) == false
      @alph_array = []; @num_array = []
      coordinates.each do |coord|
        @alph_array << coord[0]
        @num_array << coord[-1]
      end
      coords_linear?
    else
      false
    end
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.each do |coord|
        @cells[coord].place_ship(ship)
      end
    end
  end

  def render(show = false)
    cell_coords = @cells.keys 
    board_str_arr = "  " + ((("1".."30").to_a)[0..(@side_size-1)] * " ") + " \n"

    cell_coords.each_with_index do |coord, index|
      if (index % @side_size).zero?
        board_str_arr << coord.chr + " "
      end
      board_str_arr << @cells[coord].render(show) + " "
      if (index + 1) % @side_size == 0
        board_str_arr << " \n"
      end
    end
    board_str_arr
  end
end
