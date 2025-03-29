class Node
  attr_accessor :key, :value, :next_node

  def initialize(key, value)
    @key = key
    @value = value
    @next_node = nil
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
    index = get_index(key)
    current_node = @buckets[index]

    # Check if a key already exists
    if current_node.nil?
      @buckets[index] = Node.new(key, value)
      @length += 1
    else
      until current_node.next_node.nil?
        if current_node.key == key
          current_node.value = value
          return
        end
        current_node = current_node.next_node
      end
      current_node.next_node = Node.new(key, value)
      @length += 1
    end

    resize if need_resizing?
  end
  

  private

  def get_index(key)
    index = hash(key) & @capacity
    raise IndexError if index.negative? || index >= @buckets.size

    index
  end

  def need_resizing?
    @size.to_f / @capacity >= @load_factor
  end

  def resize
    old_buckets = @buckets
    @capacity *= 2
    @buckets = Array.new(@capacity)
    @length = 0

    old_buckets.each do |head|
      current_node = head
      while current_node
        set(current_node.key, current_node.value)  # Rehash all entries
        current_node = current_node.next_node
      end
    end
  end
end
