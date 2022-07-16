require './lib/cell'

class Board

  attr_reader :cells
  
  def initialize

    #prep for expanding board
    # side_size = 4
    # coord_y = (("A".."Z").to_a)[0..(side_size-1)]
    # grid_coords = []

    # coord_y.each do |letter|
    #   num = 0
    #   side_size.times do
    #     num += 1
    #     grid_coords << letter + num.to_s
    #   end
    # end

    @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4"),
    }
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
      if @cells[coord].empty == false
        return false
      end
    end
    true
  end

  def valid_placement?(ship, coordinates)
    if ship.length == coordinates.count && overlap?(coordinates)
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
end
