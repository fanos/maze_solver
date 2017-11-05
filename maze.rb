class Maze  
  require 'matrix'
  def initialize(filename)
    #Read the file with name filename and pass the included maze in a two dimensional array
    begin
     maze = File.read(filename)
    rescue
     puts "Failed to open #{filename}\nPlease check filename and try again"
     exit
    end

    @array = maze.split("\n")
    @array.map! {|x| x.chars}

    #Find width and height of maze
    @width = Matrix[*@array].row_count
    @height = Matrix[*@array].column_count

    #Find start and finish point in maze
    @start = Matrix[*@array].index("s")
    @finish = Matrix[*@array].index("f")
  end

  #Check if a given spot is inside the maze
  def maze_limits?(spot)
    -1 < spot[0] && spot[0] < @width && -1 < spot[1] && spot[1] < @height
  end

  #Find the neighbors of node(x,y)
  def neighbors_of(x,y)
    left = [x-1, y]
    right = [x+1, y]
    down = [x, y-1]
    up = [x, y+1]
    @neighbors << left << right << down << up
  end

  def bfs
    @neighbors = []
    @path = []
    @visited = []
    @previous = []
    @queue = Queue.new

    #Initialize bfs
    @visited << @start
    @queue << @start
    until @queue.empty? 
      current_node = @queue.deq
      x = current_node[0]
      y = current_node[1]
      neighbors_of(x,y)
      @neighbors.each do |neighbor|
        if maze_limits?(neighbor)
          node = @array[neighbor[0]][neighbor[1]]

          #Check whether the node has already been visited or is accesible
          if !@visited.include?(neighbor) && ( node == '-' || node == 'f')
            @visited << neighbor
            @queue << neighbor

            #Save pair of current and next node in order to find the path form s to f
            @previous << [current_node, neighbor]

            #Check if the node is finish point 
            if node == "f"
              break
            end
          end   
        end
      end
    end
  end

  def path
    bfs
    #Find the path from s to f with "previous" array
    @previous = @previous.reverse
    goal = @previous.shift
    @path << goal[1] << goal[0]
    goal = goal[0]
    @previous.each do |pair|
      if pair[1] == goal
        @path << pair[0]
        goal = pair[0]
      end
    end
    @path = @path.reverse
    return @path
  end
end