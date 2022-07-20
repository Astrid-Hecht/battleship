require './lib/board'
require './lib/graphics'
require 'pry'

class Game
  attr_accessor :player_ships_alive, :computer_ships_alive, :board_player, :board_computer, :ship_set

  def initialize(size = 4,ship_set = 'default')
    @board_player = Board.new(size, ship_set)
    @board_computer = Board.new(size, ship_set)
    @player_ships_alive = @board_player.ships.count
    @computer_ships_alive = @board_computer.ships.count
  end

  def play 
    place_phase
    who_first = Rand.new.rand(0..1)
    until @board_player == sunk || @board_computer == sunk # psuedo code, edit once taryn submits pr
      if who_first == 0
        player_shoot
        computer_shoot
      else
        computer_shoot
        player_shoot
      end
    end

  end

  def place_phase
    computer_place # Taryn navigating here
    puts "\n\n\n\n\n\nI have laid out my ships on the grid.\n"
    puts "You now need to lay out your #{@board_player.ships.length} ships."
    puts "The #{@board_player.ships[0].name} is #{@board_player.ships[0].length} units long and the #{@board_player.ships[1].name} is #{@board_player.ships[1].length} units long."
    puts @board_player.render(true)
    @board_player.ships.each do |ship|
      until player_place(ship) == true
      end
    end
  end # To here

  def computer_place
    by_lengths = (@board_computer.ships.sort_by { |ship| ship.length }).reverse
    by_lengths.each do |ship|
      place_at = coord_generator(ship)
      @board_computer.place(ship, place_at)
    end
  end

  def coord_generator(ship)
    alph_array = []
    num_array = []
    @board_computer.cells.each_key do |coord|
      alph_array << coord[0]
      num_array << coord[-1]
    end
    alph_array.uniq!
    num_array.uniq!
    valid_coords = false

    until valid_coords == true
      wiggle_room = @board_computer.side_size - ship.length
      orientation = Random.new.rand(1..2)
      if orientation == 1 # ______________________ horizontal placement _________
        start_columns = num_array[0..wiggle_room]
        start_rows = alph_array
      else # _____________________________________ vertical placement ___________
        start_columns = num_array
        start_rows = alph_array[0..wiggle_room]
      end
      start_point = start_rows[Random.new.rand(0..(start_rows.length - 1))] + start_columns[Random.new.rand(0..(start_columns.length - 1))]
      if orientation == 1 # ______________________ horizontal placement _________
        ship_coords = [start_point]
        (ship.length - 1).times do
          ship_coords << ((ship_coords[-1][0]) + (ship_coords[-1][1].ord + 1).chr).to_s
        end
      else  # ____________________________________ vertical placement ___________
        ship_coords = [start_point]
        (ship.length - 1).times do
          ship_coords << ((ship_coords[-1][0].ord + 1).chr + (ship_coords[-1][1])).to_s
        end
      end
      valid_coords = @board_computer.valid_placement?(ship, ship_coords)
    end
    ship_coords
  end

  def player_place(ship)
    puts "Enter the squares for the #{ship.name} (#{ship.length} spaces):"
    input = gets.chomp
    plyr_coords = input.split(' ')
    fixed_coords = []
    plyr_coords.each do |coord|
      fixed_coords << coord.gsub(/\d/, '').upcase + coord.gsub(/[a-zA-z]/, '')
    end
    if @board_player.valid_placement?(ship, fixed_coords)
      @board_player.place(ship, fixed_coords)
      puts @board_player.render(true)
      true
    else
      puts 'Those are invalid coordinates. Please try again.'
      false
    end
  end

  def turn
    turn_num = 1
    puts "Turn #{turn_num}"
    puts '=============COMPUTER BOARD============='
    puts @board_computer.render
    puts '==============PLAYER BOARD=============='
    puts @board_player.render(true)
    player_shoot
  end

  def computer_shoot
    rand_coord = Random.new
    cel = @board_player.cells[@board_player.cells.keys(rand_coord.rand((@board_player.side_size**2) - 1))]
    if valid_shot(cel.key, 1)
      @board_player.cells[cel].fire_upon
    else
      computer_shoot
    end
  end

  def player_shoot
    puts 'Enter the coordinate for your shot:'
    input = gets.chomp
    if valid_shot(input, 0)
      @board_computer.cells[input].fire_upon
    else
      puts 'Invalid coordinate. Please try again:'
      player_shoot
    end
  end

  def valid_shot(input, who)
    players = [@board_computer, @board_player]
    if players[who].cells[input].fired_upon == true && who == 0
      puts 'This coordinate has already been fired upon. Please try again:'
      false
    elsif players[who].cells[input].fired_upon == true && who == 1
      false
    else
      players[who].cells.include?(input)
    end
  end
end
