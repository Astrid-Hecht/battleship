require './lib/board'
require './lib/graphics'

class Game
  attr_accessor :board_player,
                :board_computer,
                :player_ships,
                :computer_ships

  def initialize(size = 4, ship_set = 'default')
    @board_player = Board.new(size, ship_set)
    @board_computer = Board.new(size, ship_set)
    @player_ships = @board_player.ships
    @computer_ships = @board_computer.ships
    @turn_num = 1
    @graphics_game = Graphics.new
  end

  def play
    place_phase
    who_first = Random.new.rand(0..1)
    until @player_ships.all? { |ship| ship.sunk? } || @computer_ships.all? { |ship| ship.sunk? } do
      if who_first == 0
        turn
        player_shoot
        computer_fire
      else
        computer_fire
        turn
        player_shoot
      end
    end
    puts end_game
    true
  end

  def place_phase
    computer_place # Taryn navigating here
    @graphics_game.place_phase(@board_player)
    puts "\n" + @board_player.render(true)
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
      until @board_computer.cells[start_point].empty?
        start_point = start_rows[Random.new.rand(0..(start_rows.length - 1))] + start_columns[Random.new.rand(0..(start_columns.length - 1))]
      end
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
    puts "Turn #{@turn_num}"
    puts '=============COMPUTER BOARD============='
    puts @board_computer.render(true)
    puts '==============PLAYER BOARD=============='
    puts @board_player.render(true)
    @turn_num += 1
  end

  def player_shoot
    puts 'Enter the coordinate for your shot:'
    input = gets.chomp.upcase
    if @board_computer.valid_coordinate?(input) && valid_shot(input, 0)
      @board_computer.cells[input].fire_upon
    else
      puts 'Invalid coordinate. Please try again:'
      player_shoot
    end
  end

  def valid_shot(input, who)
    players = [@board_computer, @board_player]
    if who == 0 && @board_computer.cells[input].fired_upon
      puts 'This coordinate has already been fired upon.'
      false
    elsif who == 1 && @board_player.cells[input].fired_upon == true
      false
    else
      players[who].cells.include?(input)
    end
  end

  def computer_fire(anim = true)
    @graphics_game.computer_shoot_anim(anim)
    cell = @board_player.cells.values.sample
    if cell.fired_upon == false
      cell.fire_upon(anim)
    else
      computer_fire
    end
  end

  def end_game
    if @player_ships.all? { |ship| ship.sunk? } && @computer_ships.all? { |ship| ship.sunk? }
      "\n\n\nMutal destruction...\n You're both dead. It's a draw"
    elsif @player_ships.all? { |ship| ship.sunk? }
      "\n\n\nI won!"
    elsif @computer_ships.all? { |ship| ship.sunk? }
      "\n\n\nYou won!"
    end
  end
end
