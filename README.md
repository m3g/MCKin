# MCKin
Computes using a MC simulation the mean first-passage times between every pair of reaction coordinates, given a PMF

### Installation

```
julia> ] add https://github.com/mcubeg/MCKin
julia> using MCKin
```

### Example (see the <a href="https://github.com/mcubeg/MCKin/blob/master/example/example.jl"> example.jl </a> file for details.)

For example, given the following Potential of Mean-Force:
<p align="center">
<img src="https://github.com/mcubeg/MCKin/blob/master/example/plots/PMF.png?raw=true">
</p>

A Monte-Carlo simulation will be performed and return the mean first-passage time from any
two points along the reaction coordinate.

For instance, the first mean passage times from the last point of the reaction coordinate
to every other point is shown in the plot below:
<p align="center">
<img src="https://github.com/mcubeg/MCKin/blob/master/example/plots/fpt350.png?raw=true">
</p>

Or, altenratively, the matrix of all mean first-passage times can be ploted:
<p align="center">
<img src="https://github.com/mcubeg/MCKin/blob/master/example/plots/fpt.png?raw=true">
</p>

