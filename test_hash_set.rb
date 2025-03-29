# test_hash_set.rb
require_relative 'hash_set' # Assuming hash_set.rb is in the same directory

puts "Testing HashSet Class:"
puts "----------------------"

set = HashSet.new(8, 0.75)

puts "Initial state:"
puts "Capacity: #{set.capacity}"
puts "Length: #{set.length}"
puts "Keys: #{set.keys}"
puts

puts "Adding elements:"
set("apple")
set("banana")
set("cherry")
set("date")
set("elderberry")
set("fig")
set("grape")
puts "Capacity after additions: #{set.capacity}"
puts "Length after additions: #{set.length}"
puts "Keys after additions: #{set.keys}"
puts

puts "Adding a duplicate element:"
set("banana")
puts "Length after adding duplicate: #{set.length} (should remain the same)"
puts "Keys after adding duplicate: #{set.keys}"
puts

puts "Checking for existence of elements:"
puts "Has 'apple'?: #{set.has?('apple')}"
puts "Has 'mango'?: #{set.has?('mango')}"
puts

puts "Removing an element:"
puts "Removed 'cherry'?: #{set.remove('cherry')}"
puts "Length after removal: #{set.length}"
puts "Keys after removal: #{set.keys}"
puts

puts "Trying to remove a non-existent element:"
puts "Removed 'kiwi'?: #{set.remove('kiwi')}"
puts "Length after trying to remove non-existent: #{set.length} (should remain the same)"
puts

puts "Adding more elements to trigger resize:"
set("honeydew")
set("kiwi")
set("lemon")
puts "Capacity after more additions (potential resize): #{set.capacity}"
puts "Length after more additions: #{set.length}"
puts "Keys after more additions: #{set.keys}"
puts

puts "Clearing the HashSet:"
set.clear
puts "Length after clear: #{set.length}"
puts "Keys after clear: #{set.keys}"
puts