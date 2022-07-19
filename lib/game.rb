require './lib/board'
require 'pry'

class Game
  attr_accessor :player_ships_alive, :computer_ships_alive, :board_player, :board_computer

  def initialize
    @board_player = Board.new
    @board_computer = Board.new
    @player_ships_alive = @board_player.ships.count
    @computer_ships_alive = @board_computer.ships.count
  end

  def play
    computer_place #Taryn navigating here
    puts 'I have laid out my ships on the grid.'
    puts "You now need to lay out your #{@board_player.ships.length} ships."
    puts "The #{@board_player.ships[0].name} is #{@board_player.ships[0].length} units long and the #{@board_player.ships[1].name} is #{@board_player.ships[1].length} units long."
    puts @board_player.render(true)
    @board_player.ships.each do |ship|
      puts "Enter the squares for the #{ship.name} (#{ship.length} spaces):"
      input = gets.chomp
      plyr_coords = input.split(' ', ship.length)
      @board_player.place(ship, plyr_coords)
      puts @board_player.render(true)
    end
    binding.pry
  end #To here

  def computer_place #not done!!
    by_lengths = (@board_computer.ships.sort_by { |ship| ship.length }).reverse
    
    # binding.pry
    by_lengths.each do |ship|
      place_at = coord_generator(ship)
      @board_computer.place(ship, place_at)
    end
  end

  def coord_generator(ship)
    alph_array = []; num_array = []
      @board_computer.cells.keys.each do |coord|
        alph_array << coord[0]
        num_array << coord[-1]
      end
      alph_array.uniq!; num_array.uniq!
    valid_coords = false 

    until valid_coords == true
      wiggle_room = @board_computer.side_size - ship.length
      orientation = Random.new.rand(1..2)
      if orientation == 1 # horizontal placement
        start_columns = num_array[0..wiggle_room]
        start_rows = alph_array
      else # vertical placement
        start_columns = num_array
        start_rows = alph_array[0..wiggle_room]
      end
      start_point = start_rows[Random.new.rand(0..(start_rows.length - 1))] + start_columns[Random.new.rand(0..(start_columns.length - 1))]
      
      if orientation == 1  # horizontal placement
        ship_coords = [start_point]
        (ship.length - 1).times do
          ship_coords << (((ship_coords[-1])[0]) + (((ship_coords[-1])[1].ord + 1).chr)).to_s
        end
      else # vertical placement
        ship_coords = [start_point]
        (ship.length - 1).times do
          ship_coords << (((ship_coords[-1])[0].ord + 1).chr + ((ship_coords[-1])[1])).to_s
        end
      end
      valid_coords = @board_computer.valid_placement?(ship, ship_coords)
    end
    ship_coords
  end

  # def computer_try_place(ship)
  #   @rand_coord = Random.new
  #   rand_orientation = Random.new #max 1
  #   orientation = rand_orientation.rand(1)
  #   cel = cel_generator
  #   center = cel.coordinates
  #   coords = [center]
  #   ship_count = 0
  #   until ship_count == ship.length do
  #     if orientation == 0 && @board_computer.cells[((((coords[-1])[0].ord + 1).chr + (coords[-1])[1]).to_s)].is_empty
  #       coords << (((coords[-1])[0].ord + 1).chr + (coords[-1])[1]).to_s
  #       ship_count += 1
  #     elsif orientation == 1  &&  @board_computer.valid_placement?(tester_ship, [((((coords[-1])[0]) + (((coords[-1])[1].ord + 1).chr)).to_s)])
  #       coords << (((coords[-1])[0]) + (((coords[-1])[1].ord + 1).chr)).to_s
  #       ship_count += 1
  #     else
  #       computer_try_place(ship)
  #     end
  #   end
  #   coords
  # end

  # def cel_generator
  #   cel = @board_computer.cells[@board_computer.cells.keys[@rand_coord.rand((@board_computer.side_size ** 2) - 1)]]
  #   until cel.empty?
  #     cel = @board_computer.cells[@board_computer.cells.keys[@rand_coord.rand((@board_computer.side_size ** 2) - 1)]]
  #   end
  #   cel
  # end

  def player_place
    puts "Enter the squares for the #{ship.name} (#{ship.length} spaces):"
    input = gets.chomp
    plyr_coords = input.split(' ', ship.length)
    if @board_player.valid_placement?(ship, plyr_coords)
      @board_player.place(ship, plyr_coords)
      puts @board_player.render(true)
    else
      puts 'Those are invalid coordinates. Please try again:'
      player_place
    end
  end

  def turn
    turn_num = 1
    puts "Turn #{turn_num}"
    puts "=============COMPUTER BOARD============="
    puts @board_computer.render
    puts "==============PLAYER BOARD=============="
    puts @board_player.render(true)
    player_shoot
  end

  def computer_shoot
    rand_coord = Random.new
    cel = @board_player.cells[@board_player.cells.keys(rand_coord.rand((@board_player.side_size ** 2) - 1))]
    if valid_shot(cel.key, 1)
      @board_player.cells[cel].fire_upon
    else
      computer_place
    end
  end

  def player_shoot
    puts 'Enter the coordinate for your shot:'
    input = gets.chomp
    if valid_shot(input, 0)
      @board_computer.cells[input].fire_upon
    else
      puts "Invalid coordinate. Please try again:"
      player_shot
    end
  end

  def valid_shot(input, who)
    players = [@board_computer, @board_player]
    if players[who].cells[input].fired_upon = true && who == 0
      puts "This coordinate has already been fired upon. Please try again:"
      false
    elsif players[who].cells[input].fired_upon = true && who == 1
      false
    else
      players[who].cells.include?(input)
    end
  end
end
