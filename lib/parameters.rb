class Parameters       # Parameters needed for menu
  def initialize; end

  def valid_side_size?(num)
    if num >= 2 && num < 10
      true
    else
      false
    end
  end

  def valid_ship? (input, size)
    input.count == 2 && input[0].is_a?(String) && input[1].is_a?(Integer) && input[1] <= size && input[1] > 0
  end
end