class Ship
  attr_reader :name, :length, :health, :sunk

  def initialize(name, length)
    @name = name.to_s
    @length = length.to_i
    @health = @length
    @sunk = false
  end

  def sunk?
    @sunk
  end

  def hit
    @health -= 1
    @sunk = true if @health <= 0
  end
end
