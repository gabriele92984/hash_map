# test_hash_map.rb
require_relative 'hash_map'

test = HashMap.new(16, 0.75)

test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')

puts "Initial length: #{test.length}"
puts "Initial capacity: #{test.capacity}"

test.set('apple', 'green') # Overwrite
test.set('banana', 'brown') # Overwrite

puts "Length after overwrite: #{test.length}"
puts "Capacity after overwrite: #{test.capacity}"

test.set('moon', 'silver')

puts "Length after resize: #{test.length}"
puts "Capacity after resize: #{test.capacity}"

puts "Get 'carrot': #{test.get('carrot')}"
puts "Has 'dog'?: #{test.has?('dog')}"
puts "Has 'sun'?: #{test.has?('sun')}"
puts "Remove 'frog': #{test.remove('frog')}"
puts "Length after remove: #{test.length}"
puts "Keys: #{test.keys}"
puts "Values: #{test.values}"
puts "Entries: #{test.entries}"

test.clear
puts "Length after clear: #{test.length}"
