require 'time'

class TSP
  INF = Float::INFINITY

  def initialize
    @graph = []
    @n = 0
    @time_start = 0
    @dp = {}
    @parent = {}
    @counts = Hash.new(0)
  end

  def run
    show_instructions
    input_graph
    validate_graph
    solve_tsp
    print_results
  end

  private

  def show_instructions
    puts "=== TSP Solver ==="
    puts "Input options:"
    puts "1. Square matrix (N x N)"
    puts "   Enter matrix values row by row"
    puts "2. Edge list (u v w)"
    puts "   Enter edges as 'u v w' lines (blank line to finish)"
    puts "   You'll be asked if edges are directional"
  end

  def input_graph
    print "Choose input type (1/2): "
    type = gets.chomp
    if type == '1'
      input_matrix
    else
      input_edges
    end
  end

  def input_matrix
    puts "Enter matrix size (N):"
    @n = gets.to_i
    puts "Enter matrix rows:"
    @graph = Array.new(@n) { gets.split.map(&:to_f) }
    @n.times do |i|
      @n.times do |j|
        @graph[i][j] = INF if @graph[i][j] <= 0 && i != j
      end
    end
  end

  def input_edges
    puts "Are edges directional? (y/n):"
    directional = gets.chomp.downcase == 'y'
    puts "Enter edges (u v w), blank line to finish:"
    edges = []
    while (line = gets.chomp) != ''
      u, v, w = line.split
      edges << [u.to_i, v.to_i, w.to_f]
    end

    nodes = edges.flat_map { |u, v, _| [u, v] }.uniq
    @n = nodes.max + 1
    @graph = Array.new(@n) { Array.new(@n, INF) }

    edges.each do |u, v, w|
      @graph[u][v] = w
      @graph[v][u] = w unless directional
    end
  end

  def validate_graph
    @n.times do |i|
      if @graph[i].all? { |w| w == INF }
        puts "Error: Node #{i} has no outgoing edges!"
        exit
      end
    end
  end

  def solve_tsp
    @time_start = Time.now
    full_mask = (1 << @n) - 1

    # DP initialization
    @dp = Hash.new { |h, k| h[k] = Hash.new(INF) }
    @parent = Hash.new { |h, k| h[k] = {} }
    @counts = Hash.new(0)

    @dp[0][1] = 0
    @counts[[0, 1]] = 1

    # Generate masks in order of increasing set bits
    masks = (0..full_mask).to_a.sort_by { |m| m.to_s(2).count('1') }

    masks.each do |mask|
      next if mask == 0

      @n.times do |u|
        next unless (mask & (1 << u)) > 0

        current_cost = @dp[u][mask]
        next if current_cost == INF

        @n.times do |v|
          next if (mask & (1 << v)) > 0

          new_mask = mask | (1 << v)
          new_cost = current_cost + @graph[u][v]

          if new_cost < @dp[v][new_mask]
            @dp[v][new_mask] = new_cost
            @parent[v][new_mask] = [u, mask]
            @counts[[v, new_mask]] = @counts[[u, mask]]
          elsif new_cost == @dp[v][new_mask]
            @counts[[v, new_mask]] += @counts[[u, mask]]
          end
        end
      end
    end

    # Calculate final cost with return to start
    @min_cost = INF
    @total_count = 0
    full_mask = (1 << @n) - 1
    @n.times do |v|
      next if v == 0

      total = @dp[v][full_mask] + @graph[v][0]
      if total < @min_cost
        @min_cost = total
        @total_count = @counts[[v, full_mask]]
      elsif total == @min_cost
        @total_count += @counts[[v, full_mask]]
      end
    end

    @path = reconstruct_path
  end

  def reconstruct_path
    full_mask = (1 << @n) - 1
    current = (0...@n).min_by { |v| @dp[v][full_mask] + @graph[v][0] }

    path = []
    mask = full_mask
  
    while current != 0
      path.unshift(current)
      current, mask = @parent[current][mask]
    end

    [0] + path + [0]
  end

  def print_results
    puts "\n=== Results ==="
    puts "Minimum cost: #{@min_cost.round(2)}"
    puts "Number of optimal paths: #{@total_count}"
    puts "Calculation time: #{Time.now - @time_start} seconds"
    puts "Optimal path: #{@path.join(' -> ')}"
  end
end

# Run the solver
TSP.new.run