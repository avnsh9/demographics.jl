"""
Simulate planetary systems and their dynamics.
"""

"""
mass_ratio_sim(q_max::Float64, q_min::Float64, n::Float64) -> `<q>`::Float64

# Arguments
- `q_max::Float64`: Maximum mass ratio (planet mass / star mass).
- `q_min::Float64`: Minimum mass ratio (planet mass / star mass).
- `n::Float64`: Power-law index for the mass ratio distribution.

# Returns
- `<q>::Float64`: Mean of planet star mass ratio.

"""
function mass_ratio_sim(q_max::Float64, q_min::Float64, n::Float64) :: Float64
    q_mean = n/(n+1)*(q_max^(n+1) - q_min^(n+1)) / (q_max^n - q_min^n)
    return q_mean
end

"""
orbit_seperation_sim(a_max::Float64, a_min::Float64, n::Float64) -> `<a>`::Float64
# Arguments
- `a_max::Float64`: Maximum orbital separation.
- `a_min::Float64`: Minimum orbital separation.
- `n::Float64`: Power-law index for the orbital separation distribution.

# Returns
- `<a>::Float64`: Mean of orbital separation.
"""
function orbit_seperation_sim(a_max::Float64, a_min::Float64, n::Float64) :: Float64
    a_mean = n/(n+1)*(a_max^(n+1) - a_min^(n+1)) / (a_max^n - a_min^n)
    return a_mean
end

"""
mean_planet_N(β::Float64, q_mean::Float64) -> `<N>`::Float64
# Arguments
- `β::Float64`: sum of all planet mass / stellar mass.
- `q_mean::Float64`: Mean of planet star mass ratio.

# Returns
- `<N>::Float64`: Mean number of planets per star.
"""
function mean_planet_N(β::Float64, q_mean::Float64) :: Float64
    N_mean = β / q_mean
    return N_mean
end

"""
random_q_sim(u::Float64, q_max::Float64, q_min::Float64, n::Float64) -> q::Float64
# Arguments
- `u::Float64`: Random uniform variable between 0 and 1.
- `q_max::Float64`: Maximum mass ratio (planet mass / star mass).
- `q_min::Float64`: Minimum mass ratio (planet mass / star mass).
- `n::Float64`: Power-law index for the mass ratio distribution.
# Returns
- `q::Float64`: Randomly sampled planet star mass ratio.
"""
function random_q_sim(u::Float64, q_max::Float64, q_min::Float64, n::Float64) :: Float64
    return (u*(q_max^n - q_min^n) + q_min^n)^(1/n)
end

"""
random_a_sim(u::Float64, a_max::Float64, a_min::Float64, n::Float64) -> a::Float64
# Arguments
- `u::Float64`: Random uniform variable between 0 and 1.
- `a_max::Float64`: Maximum orbital separation.
- `a_min::Float64`: Minimum orbital separation.
- `n::Float64`: Power-law index for the orbital separation distribution.
# Returns
- `a::Float64`: Randomly sampled orbital separation.
"""
function random_a_sim(u::Float64, a_max::Float64, a_min::Float64, n::Float64) :: Float64
    return (u*(a_max^n - a_min^n) + a_min^n)^(1/n)
end



"""
    draw_num_planets(meanN) -> num_planets::Int
# Arguments
- `meanN::Float64`: Mean number of planets per star.    
# Returns
- `num_planets::Int`: number of actual planets for one star.
# Description

Draw the number of planets for one star from a Poisson distribution
with mean ⟨N⟩.
"""
function draw_num_planets(meanN::Float64)
    return rand(Poisson(meanN))
end
