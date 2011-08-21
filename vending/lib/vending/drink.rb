class Drink
  def initialize id, cost
    @id = id
    @cost = cost
  end

  attr_reader :id
  attr_reader :cost
end
