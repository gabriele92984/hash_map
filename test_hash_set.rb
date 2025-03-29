# test_hash_set.rb
require_relative 'hash_set' # Assuming hash_set.rb is in the same directory

puts "Testing HashSet Class:"
puts "----------------------"

test = HashSet.new(8, 0.75)

puts "Initial state:"
puts "Capacity: #{test.capacity}"
puts "Length: #{test.length}"
puts "Keys: #{test.keys}"
puts

puts "Adding elements:"
test.add("apple")
test.add("banana")
test.add("cherry")
test.add("date")
test.add("elderberry")
test.add("fig")
test.add("grape")
puts "Capacity after additions: #{test.capacity}"
puts "Length after additions: #{test.length}"
puts "Keys after additions: #{test.keys}"
puts

puts "Adding a duplicate element:"
test.add("banana")
puts "Length after adding duplicate: #{test.length} (should remain the same)"
puts "Keys after adding duplicate: #{test.keys}"
puts

puts "Checking for existence of elements:"
puts "Has 'apple'?: #{test.has?('apple')}"
puts "Has 'mango'?: #{test.has?('mango')}"
puts

puts "Removing an element:"
puts "Removed 'cherry'?: #{test.remove('cherry')}"
puts "Length after removal: #{test.length}"
puts "Keys after removal: #{test.keys}"
puts

puts "Trying to remove a non-existent element:"
puts "Removed 'kiwi'?: #{test.remove('kiwi')}"
puts "Length after trying to remove non-existent: #{test.length} (should remain the same)"
puts

puts "Adding more elements to trigger resize:"
test.add("honeydew")
test.add("kiwi")
test.add("lemon")
puts "Capacity after more additions (potential resize): #{test.capacity}"
puts "Length after more additions: #{test.length}"
puts "Keys after more additions: #{test.keys}"
puts

puts "Clearing the HashSet:"
test.clear
puts "Length after clear: #{test.length}"
puts "Keys after clear: #{test.keys}"
puts
