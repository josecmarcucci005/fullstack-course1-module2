
#implicity block
def my_block
  return "No block" unless block_given?
  yield
  yield
end

puts my_block {puts "Call from the implicity provided block"}

#explicity block
def my_exp_block(&provided_block)
  return "No block" if provided_block.nil?
  provided_block.call
  provided_block.call
end

puts my_exp_block {puts "Call from the explicity provided block"}

#Working with files
begin
  File.foreach("#{Dir.pwd}/Lecture01-Ruby-Basics/beginning.rb") { |line|
    p line
  }

=begin
  #append new line to an existing file
  File.open("#{Dir.pwd}/Lecture01-Ruby-Basics/beginning.rb", "a") do |file|
    file.write "New line"
  end



  #creates if file doesn't extis and add text to the file
  File.open("#{Dir.pwd}/Lecture01-Ruby-Basics/newFile.txt", "w") do |file|
    file.write "New line"
  end
=end

rescue Exception => e
  puts e.message
end

#Getting an environment variable
puts ENV["Path"]

#Strings

myString = " tim"
puts myString.lstrip.capitalize
#prints unmodified myString value as ! methods were not used
puts myString

myString.lstrip!
myString.capitalize!
#Now it prints modified myString value as ! method were used
puts myString

#We can access the array of chars in the string!
myString[0] = 'K'
puts myString

myLongString = %Q{long multiline Strings
line 1
line 2
 }

#Nice way to iterate throu a multiline string
 myLongString.lines do |line|
   line.sub! 'long', 'some'
   puts "#{line.strip}"
 end

#I did this just by curiosity as wanted to know if by having the \r\n in a double couated string also works when retrieving the line from the string
#And indeed it works, but by having definetly going to use the %Q as is more clear
myLongString2 = "long multiline Strings\r\nline 1\r\nline 2"
myLongString2.lines do |line|
  line.sub! 'long', 'some'
  puts "#{line.strip}"
end


####Arrays
my_array = [1, "second", :three]
puts my_array[1]
puts my_array[2]

my_word_array = %w{this is an array of words}
puts my_word_array[-2]
p my_word_array[-3, 2]
p my_word_array[2..4]

puts my_word_array.join(',')

puts my_word_array.sample
p my_word_array.sort.reverse


#LIFO
stack = []; stack << "one"; stack.push("two")
puts stack.pop

#FIFO
queue = []; queue << "one"; stack.push("two")
puts queue.shift

arr = [1,2,3,4,5,6,7,8,9,10]
#foreach
arr.each {|num| print num}
puts

#select
new_arr = arr.select {|num| num > 4}
p new_arr

#reject
new_arr = arr.reject {|num| num > 4}
p new_arr

#map
new_arr = arr.map{|x| x*3}
p new_arr

#Ranges
some_range = 1..3
puts "range max is '#{some_range.max}' and range doest range include 2? '#{some_range.include?(2)}'"

puts "(1..10).include?(5.3) = #{(1..10).include?(5.3)} | (1..10) === 5.3 = #{(1..10) === 5.3}"
puts "('a'...'r').include?('r') = #{('a'...'r').include?('r')} | ('a'...'r') === 'r' = #{('a'...'r') === 'r'}"

p ('a'..'z').to_a.sample(2)

age = 55
case age
  when 0..12 then puts 'Still a baby'
  when 13..99 then puts 'Teenager at heart!'
  else puts 'You are getting older'
end

#Hashes
my_hash = {"font" => "Arial", "size" => 12, "color" => "red"}

#printing properties
puts my_hash.length
puts my_hash["font"]

#adding new elements
my_hash["background"] = "Blue"
my_hash.each_pair do |key, value|
  puts "key: #{key}, value:#{value}"
end

#assigning default
word_frequency = Hash.new(0)

sentece = "Chica chica boom boom"

sentece.split.each do |word|
  word_frequency[word.downcase] += 1
end

p word_frequency

#Using symbols in Hashes
family_tree = {oldest: "Jim", older: "Joe", younger: "Jack"}
family_tree[:youngest] =  "Jeremy"

p family_tree

def adjust_colors(props = {foreground: "red", background: "white"})
  puts "Foreground: #{props[:foreground]}" if props[:foreground]
  puts "Background: #{props[:background]}" if props[:background]
end

adjust_colors
adjust_colors foreground: "blue"
adjust_colors background: "green", foreground: "black"

#other calls but not the recommended ones
adjust_colors({background: "yella"})
adjust_colors :background => 'green'



#Classes
class Person
  #attr_accessor :age, :name creates setters and getters
  #attr_reader :age, :name creates only getters
  #attr_writer :age, :name creates only setters
  attr_reader :age
  attr_accessor :name

  def initialize(name, age)
    @name = name
    #@age = age wrong because you won't use the setter method and any age value will be allowed
    self.age = age
    puts "prints age from the contructor #{@age}"
  end

  def age= (new_age)
    @age ||= 5 #set a default in case the @age values hasn't being assigned (remember nil gives false as boolean result)
    @age = new_age unless new_age > 120
  end
end

person = Person.new("Kim", 13)
puts "My ages is #{person.age}"

person.age = 130 #try to set 130 put the setter won't allow it
puts "My ages is #{person.age}"


class MathFunctions

  def MathFunctions.double(var)
    times_called; var*2
  end

  class << self
    def times_called
      #@@times_called is a class variable (like static variable in Java!)
      @@times_called ||= 0; @@times_called += 1
    end
  end
end
def MathFunctions.triple(var)
  times_called; var*3;
end

puts MathFunctions.double(1)
puts MathFunctions.triple(2)
puts MathFunctions.times_called
