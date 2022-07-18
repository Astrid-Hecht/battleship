require './lib/board'

class BattleshipRunner

  def initialize
    @board_player = Board.new
    @board_computer = Board.new

  end

  def start
    puts 'Welcome to BATTLESHIP'
    puts 'Enter p to play. Enter q to quit.'
    input = gets.chomp
    if input == 'q'
      quit
    elsif input == 'p'
      play
    else
      puts 'Input not recognized, try again.'
      start
    end
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
  end #To here

  def quit
    abort("Bye!!")
  end

  def computer_place
  end
end

game = BattleshipRunner.new
game.start