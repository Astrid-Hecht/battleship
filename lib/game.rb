
require './lib/board'

class Game

  attr_reader :board_player, :board_computer
  def initialize
    @board_player = Board.new
    @board_computer = Board.new
    @player_ships_alive = @board.ships.count
    @computer_ships_alive = @board.ships.count
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

  def player_shoot
    puts "Enter the coordinate for your shot:"
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
    if players[who].cells[input].fired_upon = true
      puts "This coordinate has already been fired upon. Please try again:"
      false
    else
      players[who].cells.include?(input)
    end
  end

end
