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
function hr_cdpp(T)
    
    return C0 + C1*10^(0.2*(T-10)) + C2*10^(0.4*(T-10))
end