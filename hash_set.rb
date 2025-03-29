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
