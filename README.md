# TSP Solver - Dynamic Programming (Ruby)

This Ruby script implements a dynamic programming approach to solve the Traveling Salesperson Problem (TSP). It finds the minimum cost tour that visits each city exactly once and returns to the starting city. It also counts the number of such optimal paths.

## Features

* Solves the Traveling Salesperson Problem using dynamic programming with bitmasking.
* Supports two input formats for the graph:
    * **Square matrix:** Represents the cost between all pairs of cities.
    * **Edge list:** Represents the direct connections between cities with their associated costs.
* Handles both directed and undirected graphs when using the edge list input.
* Calculates and displays the minimum cost of the TSP tour.
* Counts and displays the total number of optimal TSP tours.
* Prints one of the optimal paths found.
* Measures and displays the calculation time.

## Getting Started

1.  **Save the code:** Save the provided Ruby code as a `.rb` file (e.g., `tsp_solver.rb`).

## How to Run the Code

1.  **Open your terminal:** Open the command prompt or terminal on your operating system.
2.  **Navigate to the directory:** Use the `cd` command to navigate to the folder where you saved the `tsp_solver.rb` file. For example, if you saved it in your "Downloads" folder:
    ```bash
    cd Downloads
    ```
3.  **Execute the script:** Run the Ruby script using the `ruby` command followed by the filename:
    ```bash
    ruby tsp_solver.rb
    ```
4.  **Follow the prompts:** The script will then guide you through the input process, asking you to choose the input type (matrix or edge list) and enter the graph data accordingly.

## Input

The script will prompt you to choose the input type:

### 1. Square Matrix Input

* You will be asked to enter the size of the square matrix (N).
* Then, you will need to enter the matrix values row by row, separated by spaces.
* Values less than or equal to 0 (except for the diagonal which represents the cost from a city to itself, usually 0) will be treated as infinity, indicating no direct path.

    ```
    === TSP Solver ===
    Input options:
    1. Square matrix (N x N)
        Enter matrix values row by row
    2. Edge list (u v w)
        Enter edges as 'u v w' lines (blank line to finish)
        You'll be asked if edges are directional
    Choose input type (1/2): 1
    Enter matrix size (N):
    3
    Enter matrix rows:
    0 10 15
    20 0 35
    30 25 0
    ```

### 2. Edge List Input

* You will be asked if the edges are directional (`y` for yes, `n` for no).
* Then, enter the edges one per line in the format `u v w`, where `u` and `v` are the node indices (starting from 0) and `w` is the weight (cost) of the edge.
* Press Enter on a blank line to finish entering edges.

    ```
    === TSP Solver ===
    Input options:
    1. Square matrix (N x N)
        Enter matrix values row by row
    2. Edge list (u v w)
        Enter edges as 'u v w' lines (blank line to finish)
        You'll be asked if edges are directional
    Choose input type (1/2): 2
    Are edges directional? (n)
    Enter edges (u v w), blank line to finish:
    0 1 10
    1 2 35
    2 0 30
    0 2 15
    1 0 20
    2 1 25

    ```

## Output

After processing the input and solving the TSP, the script will output:

* The minimum cost of the tour.
* The number of optimal paths found.
* The time taken to perform the calculation.
* One of the optimal paths.

    ```
    === Results ===
    Minimum cost: 80.00
    Number of optimal paths: 2
    Calculation time: 0.001... seconds
    Optimal path: 0 -> 1 -> 2 -> 0
    ```

## Algorithm

This implementation uses dynamic programming with bitmasking. The state $\text{dp}[u][\text{mask}]$ represents the minimum cost to visit all the cities in the $\text{mask}$ (a bitmask where the $i$-th bit is set if city $i$ has been visited) ending at city $u$.

The transitions are made by iterating through all possible last visited cities $u$ in the current $\text{mask}$ and then trying to move to an unvisited city $v$.

## License

This project is available under [MIT License](LICENSE).
