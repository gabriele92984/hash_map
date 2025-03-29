class Node
  attr_accessor :key, :value, :next

  def initialize(key, value)
    @key = key
    @value = value
    @next = nil
  end
end

class HashMap
  attr_reader :capacity, :load_factor, :length

  def initialize(initial_capacity = 16, load_factor = 0.75)
    @capacity = initial_capacity
    @load_factor = load_factor
    @buckets = Array.new(@capacity)
    @length = 0
  end

  def hash(key)
    raise TypeError, 'Key must be a string' unless key.is_a?(String)
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
    if entry = bucket.find { |k, _| k == key } 
      entry[1] = value
      return
    end

    bucket << [key, value]
    @size += 1
    resize if need_resizing?
  end
  

  private

  def needs_resizing?
    @size.to_f / @capacity >= @load_factor
  end

  def resize
    old_buckets = @buckets
    @capacity *= 2
    @buckets = Array.new(@capacity)
    @size = 0

    old_buckets.each do |head|
      current = head
      while current
        set(current.key, current.value)  # Rehash all entries
        current = current.next_node
      end
    end
  end
end
