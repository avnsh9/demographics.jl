"""
Demographics package for simulating stellar and planetary systems.
"""
module demographics

# Write your package code here.
export hr_cdpp

include("star.jl")
include("planet_sim.jl")

end
