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
      while current_node
        if current_node.key == key
          current_node.value = value 
          return # Value updated, no need to add a new node
        end
        break if current_node.next_node.nil?
        current_node = current_node.next_node
      end
      current_node.next_node = Node.new(key, value)
      @length += 1
    end

    resize if need_resizing?
  end

  def get(key)
    index = get_index(key)
    current_node = @buckets[index]

    while current_node
      return current_node.value if current_node.key == key
      current_node = current_node.next_node
    end
    nil
  end
  
  def has?(key)
    index = get_index(key)
    current_node = @buckets[index]

    while current_node
      return true if current_node.key == key
      current_node = current_node.next_node
    end
    false
  end

  def remove(key)
    index = get_index(key)
    current_node = @buckets[index]
    previous_node = nil

    while current_node
      if current_node.key == key
        if previous_node
          previous_node.next_node = current_node.next_node
        else
          @buckets[index] = current_node.next_node # Head of the list
        end
        @length -= 1
        return current_node.value
      end
      previous_node = current_node
      current_node = current_node.next_node
    end
    nil
  end

  def length
    @length
  end

  def clear
    @buckets = Array.new(@capacity)
    @length = 0
  end

  def keys
    all_keys = []
    @buckets.each do |entry|
      current_node = entry
      while current_node
        all_keys << current_node.key
        current_node = current_node.next_node
      end
    end
    all_keys
  end

  def values
    all_values = []
    @buckets.each do |entry|
      current_node = entry
      while current_node
        all_values << current_node.value
        current_node = current_node.next_node
      end
    end
    all_values
  end

  def entries
    all_entries = []
    @buckets.each do |entry|
      current_node = entry
      while current_node
        all_entries << [current_node.key, current_node.value]
        current_node = current_node.next_node
      end
    end
    all_entries
  end

  private

  def get_index(key)
    index = hash(key) % @capacity
    raise IndexError if index.negative? || index >= @buckets.length
    index
  end

  def need_resizing?
    @length.to_f / @capacity >= @load_factor
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

class HashSet
  attr_reader :load_factor, :capacity, :length

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

  def set(key)
    index = get_index(key)
    bucket = @buckets[index]

    if bucket.nil?
      @buckets[index] = [key]
      @length += 1
    elsif !bucket.include?(key)
      bucket << key
      @length += 1
    end

    resize if @length.to_f / @capacity > @load_factor
  end

  def has?(key)
    index = get_index(key)
    bucket = @buckets[index]
    return false if bucket.nil?

    bucket.include?(key)
  end

  def remove(key)
    index = get_index(key)
    bucket = @buckets[index]
    return nil if bucket.nil?

    original_length = bucket.length
    bucket.reject! { |item| item == key }

    if bucket.length < original_length
      @length -= 1
      return true
    end
    nil
  end

  def clear
    @buckets = Array.new(@capacity)
    @length = 0
  end

  def length
    @length
  end

  def keys
    @buckets.compact.flatten
  end

  private

  def get_index(key)
    index = hash(key) % @capacity
    raise IndexError if index.negative? || index >= @buckets.length
    index
  end

  def resize
    old_buckets = @buckets
    @capacity *= 2
    @buckets = Array.new(@capacity)
    @length = 0

    old_buckets.compact.each do |bucket|
      bucket.each { |key| add(key) }
    end
  end
end
