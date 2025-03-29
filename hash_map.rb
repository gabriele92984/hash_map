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

    hash_code
  end

  def set(key, value)
    index = hash(key) % @capacity
    raise IndexError if index.negative? || index >= @buckets.size
    
    bucket = @buckets[index]
    # Check if a key already exists
    if pair = bucket.find { |k, _| k == key }
      pair[1] = value
      return
    end

    bucket << [key, value]
    @size += 1
    resize if needs_resizing?
  end
  

  def needs_resizing?
    @size.to_f / @capacity >= @load_factor
  end

  def resize
    old_buckets = @buckets
    @capacity *= 2
    @buckets = Array.new(@capacity) { [] }
    size = 0
    
    old_buckets.each do |bucket|
      bucket.each { |pair| set(pair[0], pair[1]) }
    end
  end
end
