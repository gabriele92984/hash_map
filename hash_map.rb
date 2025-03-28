class HashMap
  attr_reader :capacity, :load_factor

  def initialize(initial_capacity = 16, load_factor = 0.75)
    @buckets = Array.new(initial_capacity) { [] }
    @capacity = initial_capacity
    @load_factor = load_factor
    @size = 0
  end

  
end
