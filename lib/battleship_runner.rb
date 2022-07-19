require './lib/board'
require './lib/game'

class BattleshipRunner 
  def initialize 
    @game = Game.new
  end

  def start
    puts 'Welcome to BATTLESHIP'
    puts 'Enter p to play. Enter q to quit.'
    input = gets.chomp
    if input == 'q'
      quit
    elsif input == 'p'
      @game.play
    else
      puts 'Input not recognized, try again.'
      start
    end
  end

  def quit
    abort("Bye!!")
  end
end

run = BattleshipRunner.new
run.start
