"""
Demographics package for simulating stellar and planetary systems.
"""
module demographics
using Distributions
using SpecialFunctions


# Write your package code here.

include("constants.jl")
include("star.jl")
include("planet_sim.jl")
include("transit_simulation.jl")
include("utils.jl")

end
