load 'maze.rb'

#Ask user to define a maze file
puts "Please insert the filename of a maze"
filename = gets.chomp

#Create new maze object
maze = Maze.new(filename)
path = maze.path

puts "--------------------"
puts "The path from start point 's' to finish point 'f' is:"
p path