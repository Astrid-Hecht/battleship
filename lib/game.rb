require './lib/ship'
require './lib/cell'
require './lib/board'

class Game

  attr_reader :board_player, :board_computer
  def initialize
    @board_player = Board.new
    @board_computer = Board.new
    # @player_submarine = Ship.new("Submarine", 2)
    # @player_cruiser = Ship.new("Cruiser", 3)
    # @player_destroyer = Ship.new("Destroyer", 4)
    # @comp_submarine = Ship.new("Submarine", 2)
    # @comp_cruiser = Ship.new("Cruiser", 3)
    # @comp_destroyer = Ship.new("Destroyer", 4)
    # @player_ships_alive = @board_player.ships.count
    # @computer_ships_alive = @board_computer.ships.count
    @player_ships = @board_player.ships
    @computer_ships = @computer_player.ships
  end

  def play
    computer_place #Taryn navigating here
    puts 'I have laid out my ships on the grid.'
    puts "You now need to lay out your #{@board_player.ships.length} ships."
    puts "The #{@board_player.ships[0].name} is #{@board_player.ships[0].length} units long and the #{@board_player.ships[1].name} is #{@board_player.ships[1].length} units long."
    puts @board_player.render(true)
    @board_player.ships.each do |ship|

    end
  end #To here

  def computer_place #not done!!
    by_lengths = @board_computer.ships.sort_by { |ship| ship.length }
    by_lengths.each do |ship|
      rand_coord = Random.new
      rand_orientation = Random.new #max 4
      orientation = rand_orientation.rand(3)
      center = @board_computer.cells[@board_computer.cells.keys(rand_coord.rand((@board_computer.side_size ** 2) - 1))]
      coords = [center]
      if orientation == 0 && center.chr != "A"
        coords << ((center.ord - 1).chr + center[1]).to_s
        orientation = 2
      elsif orientation == 1 && center[1] != "4"
        coords << (center.chr + (center[1].ord + 1).chr).to_s
        orientation = 3
      elsif orientation == 2 && center.chr != "D"

      (ship.length - 1).times do
      end

    end
  end

      if valid_placement?

      else
        computer_place
      end
  end

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

  def computer_fire
    cell = @board_player.cells.values.sample
    if cell.fired_upon == false
      cell.fire_upon
    else
      computer_fire
    end
  end

  def end_game
    if @player_ships.all? { |ship| ship.sunk? }
      p "I won!"
    elsif @computer_ships.all? { |ship| ship.sunk? }
      p "You won!"
    end
    play
  end

end
