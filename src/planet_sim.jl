"""
    mass_ratio_sim(q_max, q_min, n) -> q_mean

# Arguments
- `q_max::Float64`: Maximum mass ratio (planet mass / star mass).
- `q_min::Float64`: Minimum mass ratio (planet mass / star mass).
- `n::Float64`: Power-law index for the mass ratio distribution.

# Returns
- `q_mean::Float64`: Mean of planet star mass ratio.

# Description
Calculate mean planet/star mass ratio from distribution parameter. Priyadarshi et. al. (2025)

"""
function mass_ratio_sim(q_max::T, q_min::T, n::T) where T<:AbstractFloat
    q_mean = n / (n + 1) * (q_max^(n + 1) - q_min^(n + 1)) / (q_max^n - q_min^n)
    return q_mean
end

"""
    orbit_seperation_sim(a_max, a_min, n) -> a_mean

# Arguments
- `a_max::Float64`: Maximum orbital separation.
- `a_min::Float64`: Minimum orbital separation.
- `n::Float64`: Power-law index for the orbital separation distribution.

# Returns
- `a::Float64`: Mean of orbital separation.

Description
Calculate mean orbit seperation of planet distribution from parameters. Priyadarshi et. al. (2025)
"""
function orbit_seperation_sim(a_max::T, a_min::T, n::T) where T<:AbstractFloat
    a_mean = n / (n + 1) * (a_max^(n + 1) - a_min^(n + 1)) / (a_max^n - a_min^n)
    return a_mean
end

"""
    mean_planet_N(β, q_mean) -> N

# Arguments
- `β::Float64`: sum of all planet mass / stellar mass.
- `q_mean::Float64`: Mean of planet star mass ratio.

# Returns
- `N::Float64`: Mean number of planets per star.

# Description
Calculates mean of number of planets around a star based on mean mass. Priyadarshi et. al. (2025)
"""
function mean_planet_N(β::T, q_mean::T) where T<:AbstractFloat
    N_mean = β / q_mean
    return N_mean
end

"""
    random_q_sim(u, q_max, q_min, n) -> q

# Arguments
- `u::Float64`: Random uniform variable between 0 and 1.
- `q_max::Float64`: Maximum mass ratio (planet mass / star mass).
- `q_min::Float64`: Minimum mass ratio (planet mass / star mass).
- `n::Float64`: Power-law index for the mass ratio distribution.

# Returns
- `q::Float64`: Randomly sampled planet star mass ratio.

# Description
Randomly sampled planet star mass ratio.
"""
function random_q_sim(u::T, q_max::T, q_min::T, n::T) where T<:AbstractFloat
    return (u * (q_max^n - q_min^n) + q_min^n)^(1 / n)
end

"""
    random_a_sim(u, a_max, a_min, n) -> a

# Arguments
- `u::Float64`: Random uniform variable between 0 and 1.
- `a_max::Float64`: Maximum orbital separation.
- `a_min::Float64`: Minimum orbital separation.
- `n::Float64`: Power-law index for the orbital separation distribution.

# Returns
- `a::Float64`: Randomly sampled orbital separation.

# Description
Returns a randomly sampled orbit seperation value based on the distribution.
"""
function random_a_sim(u::T, a_max::T, a_min::T, n::T) where T<:AbstractFloat
    return (u * (a_max^n - a_min^n) + a_min^n)^(1 / n)
end



"""
    draw_num_planets(meanN) -> num_planets

# Arguments
- `meanN::Float64`: Mean number of planets per star.    

# Returns
- `num_planets::Int`: number of actual planets for one star.

# Description
Draw the number of planets for one star from a Poisson distribution with mean ⟨N⟩.
"""
function draw_num_planets(meanN::Float64)
    return rand(Poisson(meanN))
end


"""
    draw_orbital_eccentricity(N,α,β) -> e_array

# Arguments
- `N::Int`: Number of planets.
- `α::Float64`: Alpha parameter for the Beta distribution.
- `β::Float64`: Beta parameter for the Beta distribution.

# Returns
- `e_array`: Array of orbital eccentricities for the planets.

# Description
Draw orbital eccentricities for N planets from a Beta distribution with parameters α and β. Van Eylen & Albrecht
2015
"""
function draw_orbital_eccentricity(N::Int, α::T, β::T) where T<:AbstractFloat
    e_array = rand(Beta(α, β), N)
    return e_array
end

"""
    draw_periastron_angle(N) -> ω_array

# Arguments
- `N::Int`: Number of planets.

# Returns
- `ω_array`: Array of periastron angles for the planets.

# Description
Draw periastron angles for N planets from a uniform distribution between -π and π
"""
function draw_periastron_angle(N::Int)
    ω_array = rand(Uniform(-π, π), N)
    return ω_array
end

"""
    draw_inclination_angle(N) -> cosi_array

# Arguments
- `N::Int`: Number of planets.

# Returns
- `cosi_array`: Array of cosine of inclination angle for the planets.

# Description
Draw inclination angles cosine for N planets from a uniform distribution between 0 and 1
"""
function draw_inclination_angle(N::Int)
    cosi_array = rand(Uniform(0, 1), N)
    return cosi_array
end

