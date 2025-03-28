class HashMap
  attr_reader :capacity, :load_factor

  def initialize(initial_capacity = 16, load_factor = 0.75)
    @buckets = Array.new(initial_capacity) { [] }
    @capacity = initial_capacity
    @load_factor = load_factor
    @size = 0
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code % @capacity
  end

  def set(key, value)
    index = hash(key)
    
    # Use the following snippet whenever you access a bucket through an index. We want to
    # raise an error if we try to access an out-of-bounds index
    raise IndexError if index.negative? || index >= @buckets.size
    bucket = @buckets[index]

    # Check if a key already exists
    entry = bucket.find { |pair| pair[0] == key }
    if entry
      entry[1] == value
    else
      bucket << [key, value]
      @size += 1
      resize if need_resize?
    end

    def need_resize?
      (@size.to_f / @capacity) >= @load_factor
  end
end
