load 'maze.rb'

#Ask user to define a maze file
puts "Please insert the filename of a maze"
filename = gets.chomp

#Create new maze object
maze = Maze.new
maze.initialization(filename)
#Create new solution for maze
maze_solution = Solution.new
path = maze_solution.path

puts 
puts "The path from start point 's' to finish point 'f' is:"
p path