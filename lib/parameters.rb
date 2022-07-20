class Parameters
  def initialize; end

  def valid_side_size?(num)
    if num >= 2 && num < 10
      true
    else
      false
    end
  end
end