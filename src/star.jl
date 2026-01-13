"""
Star related functions for demographics package.
"""

"""
hr_cdpp(T)

# Arguments
- `T::Float64`: TESS magnitude of the star.
# Returns
- `Float64`: 1-hour CDPP in ppm.
# Description

- Calculate one hour CDPP to get detectibility metric for TESS data.
- Equation 1 from Kunimoto et al. (2022).
"""
function hr_cdpp(Temp::T, C0::T, C1::T, C2::T) where T<:AbstractFloat
    
    return C0 + C1*10^(0.2*(Temp-10)) + C2*10^(0.4*(Temp-10))
end