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

### For Windows

1.  **Ensure Ruby is installed:**
    * Open your web browser and go to the official RubyInstaller for Windows website: [https://rubyinstaller.org/](https://rubyinstaller.org/).
    * Download the recommended version of Ruby+Devkit. The Devkit is often needed for installing certain Ruby gems (though this script doesn't strictly require external gems, it's good to have).
    * Run the downloaded installer. Follow the on-screen instructions. Make sure to check the box that says "Add Ruby executables to your PATH" during the installation. This allows you to run Ruby from the command prompt.
    * If you chose to install Ruby+Devkit, the installer will likely prompt you to run `ridk install` at the end. It's generally recommended to select option `3` (MSYS2 base installation) and let it complete.

2.  **Open Command Prompt:**
    * Press the Windows key, type `cmd`, and press Enter. This will open the Command Prompt window.

3.  **Navigate to the directory:**
    * Use the `cd` command to navigate to the folder where you saved the `tsp_solver.rb` file :
        ```bash
        cd <root_directory>
        ```

4.  **Execute the script:**
    * Once you are in the correct directory, run the Ruby script using the `ruby` command followed by the filename:
        ```bash
        ruby tsp_solver.rb
        ```
    * The script will then start, and you will be prompted to choose the input type and enter the graph data.

### For Linux (Ubuntu/Debian based example)

1.  **Ensure Ruby is installed:**
    * Most Linux distributions come with Ruby pre-installed. You can check if Ruby is installed by opening a terminal and typing:
        ```bash
        ruby -v
        ```
        If Ruby is not installed or you need a specific version, you can install it using your distribution's package manager. For Ubuntu/Debian:
        ```bash
        sudo apt update
        sudo apt install ruby-full
        ```
        For Fedora/CentOS:
        ```bash
        sudo dnf install ruby
        ```

2.  **Open Terminal:**
    * Open the terminal application on your Linux system. You can usually find it in your applications menu or by pressing `Ctrl+Alt+T`.

3.  **Navigate to the directory:**
    * Use the `cd` command to navigate to the folder where you saved the `tsp_solver.rb` file : 
        ```bash
        cd <root_directory>
        ```
4.  **Execute the script:**
    * Once you are in the correct directory, run the Ruby script using the `ruby` command followed by the filename:
        ```bash
        ruby tsp_solver.rb
        ```
    * The script will then start, and you will be prompted to choose the input type and enter the graph data.

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
