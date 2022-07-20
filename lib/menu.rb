require './lib/game'
require './lib/graphics'
require './lib/parameters'

class Menu
  def initialize
    @game = Game.new
    @ship_set = []
    @graphics = Graphics.new
    @parameters = Parameters.new
  end

  def start
    @graphics.menu_screen
    input = gets.chomp
    if input.downcase == 'q'
      quit
    elsif input.downcase == 'p'
      @game.play
    elsif input.downcase == 'c'
      customize_board
    else
      @graphics.clear_screen
      @graphics.input('Input not recognized, try again.')
      sleep(2)
      start
    end
  end

  def customize_board
    @graphics.customize_board_screen
    @size_input = gets.chomp.to_i
    if @parameters.valid_side_size?(@size_input) == false
      @graphics.clear_screen
      puts "!!!!!! Invalid size, try again !!!!!!\n\n\n\n\n"
      sleep(2)
      customize_board
    end
    @graphics.customize_ships_screen
    @graphics.input('Would you like to customize ships? [y/n]')
    input2 = gets.chomp.downcase
    if @parameters.valid_side_size?(@size_input) && input2 == 'n'
      @graphics.clear_screen
      @graphics.input('Generating new game...')
      @game = Game.new(@size_input)
      @game.play
    elsif @parameters.valid_side_size?(@size_input) && input2 == 'y'
      customize_ships
    else
      @graphics.clear_screen
      @graphics.input('Nope, try again')
      sleep(3)
      customize_board
    end
  end

  def customize_ships
    if @ship_set == []
      @graphics.customize_ships_screen
      @graphics.input("No ships have been added. Please add a ship with the following format: <name, size> \nExample: Cruiser, 3")
    elsif @ship_set.count >= 25
      @graphics.customize_ships_screen
      @graphics.input('Ship limit reached... Generating new game')
      sleep(1.5)
      @game = Game.new(@size_input, @ship_set)
      @game.play
    else
      @graphics.customize_ships_screen
      @graphics.input("Current ship set: #{@ship_set}\n Would you like to add another ship? [y/n]")
      input = gets.chomp
      @graphics.customize_ships_screen
      if input == 'n'
        @graphics.input('Starting custom game...')
        sleep(1.5)
        @game = Game.new(@size_input, @ship_set)
        @game.play
      else
        @graphics.input('Please add a ship with the following format: <name, size>')
      end
    end
    input = gets.chomp.downcase.split(', ')
    input[1] = input[1].to_i
    @graphics.customize_ships_screen
    if input.count == 2 && input[0].is_a?(String) && input[1].is_a?(Integer) && input[1] <= @size_input && input[1] > 0
      @ship_set << Ship.new(input[0], input[1])
      @graphics.input('Ship added.')
    else
      @graphics.input('Invalid input. Ship not saved, please try again.')
    end
    sleep(1.5)
    customize_ships
  end

  def quit
    @graphics.quit_screen
  end
end
