"""
Simulate a transiting exoplanet population and their detection probabilities.
"""

"""
    impact_parameter(a,cosi,e,Rₛ,ω) -> b

# Arguments
- `a::Float64`: Semi-major axis of the planet's orbit.
- `cosi::Float64`: Cosine of the inclination angle.
- `e::Float64`: Orbital eccentricity.
- `Rₛ::Float64`: Radius of the star.
- `ω::Float64`: Periastron angle.

# Returns
- `b::Float64`: Impact parameter of the transit.

# Description
Calculate the impact parameter of a transiting exoplanet given its orbital parameters and the host star's radius.
"""
function impact_parameter(a::T, cosi::T, e::T, Rₛ::T, ω::T) where T<:AbstractFloat
    b = (a * cosi / Rₛ) * ((1 - e^2) / (1 + e * sin(ω)))
    return b
end

"""
    transit_duration(a, Rₛ, Rₚ, e, ω, cosi, P) -> T_dur

# Arguments
- `a::Float64`: Semi-major axis of the planet's orbit.
- `Rₛ::Float64`: Radius of the star.
- `Rₚ::Float64`: Radius of the planet.
- `e::Float64`: Orbital eccentricity.
- `ω::Float64`: Periastron angle.
- `cosi::Float64`: Cosine of the inclination angle.
- `P::Float64`: Orbital period of the planet.
- `b::Float64`: Impact parameter of the transit.

# Returns
- `T_dur::Float64`: Duration of the transit in hour.

# Description
Calculate the duration of a transit for a planet given its orbital parameters and the host star's radius
"""
function transit_duration(a::T, Rₛ::T, Rₚ::T, e::T, ω::T, cosi::T, P::T,b::T) where T<:AbstractFloat
    num1 = sqrt((1+Rₚ/Rₛ)^2 - b^2)
    den1 = sqrt(1 - cosi^2)
    num2 = sqrt(1 - e^2)
    den2 = 1 + e * sin(ω)
    T_dur = 24 * (P/π) * asin(Rₛ/a * (num1/den1)) * (num2/den2)
    return T_dur

end

"""
    transit_SNR(Rₚ,Rₛ,CDPP,T_dur,δ,Cont) -> SNR


# Arguments
- `Rₚ::Float64`: Radius of the planet.
- `Rₛ::Float64`: Radius of the star.
- `CDPP::Float64`: Combined Differential Photometric Precision of the star.
- `T_dur::Float64`: Duration of the transit in hours.
- `δ::Float64`: Transit depth.
- `Cont::Float64`: Star's contamination ratio from CTL.

# Returns
- `SNR::Float64`: Signal-to-noise ratio of the transit.

# Description
Calculate the signal-to-noise ratio (SNR) of a transit given the planet and star parameters.
"""
function transit_SNR(Rₚ::T, Rₛ::T, CDPP::T, T_dur::T, δ::T, Cont::T) where T<:AbstractFloat
    SNR = (Rₚ/Rₛ)^2 * 1e6 * sqrt(T_dur) / ((1+Cont) * CDPP) 
    return SNR
    
end


