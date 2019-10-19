# MCKin
Computes using a MC simulation the mean first-passage times between every pair of reaction coordinates, given a PMF

### Installation

```
julia> ] add https://github.com/mcubeg/MCKin
julia> using MCKin
```

### Example (see the 
<a href="https://github.com/mcubeg/topolink/blob/master/julia/examples/davis_nxl.jl">
example.jl
</a> 
file for details.)

For example, given the following Potential of Mean-Force:
<p align="center">
<img src="https://github.com/mcubeg/MCKin/blob/master/example/PMF.pdf?raw=true">
</p>

A Monte-Carlo simulation will be performed and return the mean first-passage time from any
two points along the reaction coordinate.

For instance, the first mean passage times from the last point of the reaction coordinate
to every other point is shown in the plot below:
<p align="center">
<img src="https://github.com/mcubeg/MCKin/blob/master/example/fpt350.pdf?raw=true">
</p>

Or, altenratively, the matrix of all mean first-passage times can be ploted:
<p align="center">
<img src="https://github.com/mcubeg/MCKin/blob/master/example/fpt.pdf?raw=true">
</p>

