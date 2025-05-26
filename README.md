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
   Minimum cost: 60.0
   Number of optimal paths: 2
   Calculation time: 0.000118742 seconds
   Optimal path: 0 -> 2 -> 1 -> 0
    ```

## Algorithm

This implementation uses dynamic programming with bitmasking. The state $\text{dp}[u][\text{mask}]$ represents the minimum cost to visit all the cities in the $\text{mask}$ (a bitmask where the $i$-th bit is set if city $i$ has been visited) ending at city $u$.

The transitions are made by iterating through all possible last visited cities $u$ in the current $\text{mask}$ and then trying to move to an unvisited city $v$.

Here's a formal description of the bitmask dynamic programming formula used in the TSP solver:

Let $N$ be the number of cities (nodes) in the graph, indexed from $0$ to $N-1$.
Let $C(i, j)$ be the cost (weight) of the edge from city $i$ to city $j$. If there is no direct edge, $C(i, j) = \infty$.

We define a 2D DP table, $\text{dp}[S][i]$, where:

* $S$ is a bitmask representing the set of cities already visited in the current path. The $k$-th bit of $S$ is set to $1$ if city $k$ has been visited, and $0$ otherwise.

* $i$ is the last city visited in the path represented by the bitmask $S$.

$\text{dp}[S][i]$ stores the minimum cost of a path that starts at city $0$, visits all cities in the set $S$, and ends at city $i$.

### **1. Base Case**

The base case initializes the DP table for the starting city.
Since the path starts at city $0$, the initial state is when only city $0$ has been visited, and it is the last city visited.

$$
\text{dp}[1 \ll 0][0] = 0
$$

This means the cost of a path that starts at city $0$, visits only city $0$ (represented by the bitmask $1 \ll 0$, which is $1$), and ends at city $0$ is $0$. All other $\text{dp}[S][i]$ values are initialized to $\infty$.

### **2. Recurrence Relation**

To compute $\text{dp}[S][i]$, we consider all possible previous cities $j$ from which we could have arrived at city $i$.
For each city $i$ and each bitmask $S$ such that the $i$-th bit is set in $S$ (i.e., $(S \text{ AND } (1 \ll i)) \neq 0$), and $i \neq 0$ (since city $0$ is the starting point and we are building paths ending at $i$ after visiting other cities):

$$
\text{dp}[S][i] = \min_{j \in S \setminus {i}} \left( \text{dp}[S \setminus {i}][j] + C(j, i) \right)
$$

where:

* $S \setminus {i}$ represents the bitmask $S$ with the $i$-th bit unset (i.e., $S \text{ XOR } (1 \ll i)$). This means we are looking at the state where all cities in $S$ except $i$ were visited, ending at city $j$.

* The minimum is taken over all cities $j$ that were part of the path before $i$ (i.e., $j$ is in the set $S$ and $j \neq i$).

The computation proceeds by iterating through masks $S$ in increasing order of the number of set bits (or simply by increasing integer value), and for each mask, iterating through all possible ending cities $i$.

### **3. Final Solution (Minimum Tour Cost)**

After filling the $\text{dp}$ table, the minimum cost of the Traveling Salesperson Tour (which starts at city $0$, visits all other cities exactly once, and returns to city $0$) is found by:

$$
\text{MinCost} = \min_{i=1 \dots N-1} \left( \text{dp}[(1 \ll N) - 1][i] + C(i, 0) \right)
$$

where:

* $(1 \ll N) - 1$ is the bitmask where all $N$ bits are set, representing that all cities have been visited.

* The minimum is taken over all possible cities $i$ (from $1$ to $N-1$) that could be the second-to-last city in the tour before returning to city $0$.

* $C(i, 0)$ is the cost to travel from city $i$ back to the starting city $0$.

### **4. Counting Optimal Paths**

To count the number of optimal paths, we introduce another DP table, $\text{counts}[S][i]$, which stores the number of paths that achieve the minimum cost $\text{dp}[S][i]$.

* **Base Case:**

  $$
\text{counts}[1 \ll 0][0] = 1
$$

* **Recurrence Relation:**
  When calculating $\text{dp}[S][i]$:

  * If $\text{dp}[S \setminus {i}][j] + C(j, i) < \text{dp}[S][i]$:

    $$
\text{counts}[S][i] = \text{counts}[S \setminus {i}][j]
$$

    (A new minimum is found, so reset the count to the count of the path leading to this new minimum)

  * If $\text{dp}[S \setminus {i}][j] + C(j, i) = \text{dp}[S][i]$:

    $$
\text{counts}[S][i] += \text{counts}[S \setminus {i}][j]
$$

    (An alternative path with the same minimum cost is found, so add its count)

* **Total Optimal Paths:**
  The total number of optimal paths for the full tour is:

  $$
\text{TotalOptimalPaths} = \sum_{i=1 \dots N-1 \text{ s.t. } \text{dp}[(1 \ll N) - 1][i] + C(i, 0) = \text{MinCost}} \text{counts}[(1 \ll N) - 1][i]
$$

  This sums the counts for all second-to-last cities $i$ that lead to the overall $\text{MinCost}$.

## License

This project is available under [MIT License](LICENSE).
