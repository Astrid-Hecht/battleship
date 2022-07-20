require './lib/menu'

class BattleshipRunner
  def initialize 
    @menu = Menu.new
  end

  def run
    @menu.start
  end
end

run = BattleshipRunner.new
run.run
