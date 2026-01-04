"""
Baseline CDPP coefficient.
"""
const C0 = 50.2

"""
First magnitude coefficient.
"""
const C1 = 97.4

"""
Second magnitude coefficient.
"""
const C2 = 92.9

"""
α coefficient for beta distributions of eccentricities
"""
const α = 1.03

"""
β coefficient for beta distribution of eccentricities
"""
const β = 13.6


"""
Kepler DR25 detection coefficients for calculating detection probability, given number of transits and expected SNR. Taken from Hsu et al. (2019)
"""
const KEPLER_DR25_PARAMS = (
    tr3 = (α = 33.3884, β = 0.264472, c = 0.699093),
    tr4 = (α = 32.8860, β = 0.269577, c = 0.768366),
    tr5 = (α = 31.5196, β = 0.282741, c = 0.833673),
    tr6 = (α = 30.9919, β = 0.286979, c = 0.859865),
    tr7_9 = (α = 30.1906, β = 0.294688, c = 0.875042),
    tr10_18 = (α = 31.6342, β = 0.279425, c = 0.886144),
    tr19_36 = (α = 32.6448, β = 0.268898, c = 0.889724),
    tr37p = (α = 27.8185, β = 0.32432, c = 0.945075),
)

