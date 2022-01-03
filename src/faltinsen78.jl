
struct LinearFaltinsen78
    a::Float64
    h::Float64
    μ::Float64
    ω::Float64
    A::Float64
    g::Float64
    N::Int
    Aₙ::Vector{Float64}
    Bₙ::Vector{Float64}
    Cₙ::Vector{Float64}
    Dₙ::Vector{Float64}
    ωₙ²::Vector{Float64}
    Kₙ::Vector{Float64}
end


function LinearFaltinsen78(N, ω, a, h, μ; g=9.8, A=1.0)

    Kₙ = zeros(N+1)
    Aₙ = zeros(N+1)
    B\ = zeros(N+1)
    C = zeros(N+1)
    D = zeros(N+1)
    ωₙ = zeros(N+1)

    ω² = ω^2
    μ² = μ^2
    
    n = 0:N
    npia = @. (2n+1)*π / 2a
    
    ωₙ² = @.  g * npia * tanh( npia * h) 
    Kₙ = @. ω*A/cosh(npia*h) * 2/a * (1/npia)^2 * (-1)^n

    Δω = @. (ωₙ² - ω²)
    den = @. Δω^2 + μ²*ω²
    
    Cₙ = @. Kₙ * (ω * Δω - μ²*ω) / den
    Dₙ = @. Kₙ * (Δω*μ + μ*ω²) / den

    Aₙ = @. -Cₙ - Kₙ*ω
    Bₙ = @. 1 / sqrt(ωₙ² - μ²/4) * (-μ/2*Aₙ - ω*Dₙ)

    return LinearFaltinsen78(a, h, μ, ω, A, g, N, Aₙ, Bₙ, Cₙ, Dₙ, ωₙ², Kₙ)
end

function Tₙ(f::LinearFaltinsen78, n, t)
    m = n-1
    μ = f.μ
    μ² = μ^2
    ωₙ² = f.ωₙ²[m]
    Aₙ = f.Aₙ[m]
    Bₙ = f.Bₙ[m]
    Cₙ = f.Cₙ[m]
    Dₙ = f.Dₙ[m]
    
    ω = f.ω

    ω₁ = sqrt(ωₙ²[n-1] - μ²/4)

    return exp(-μ/(2t)) * ( Aₙ * cos(ω₁*t) + Bₙ*sin(ω₁*t) ) +
        Cₙ * cos(ω*t) + Dₙ*cos(ω*t)
end

function potential₁(f::LinearFaltinse78, x, y, t)
    N = f.N
    ϕ₁ = 0.0
    ω = f.ω
    a = f.a
    h = f.h
    
    for n in 0:N
        npia = (2n+1)*π / 2a
        T = Tₙ(f, n, t)
        ϕ₁ = ϕ₁ + T * sin(npia*x) * cosh(npia*(y+h))
    end
    return ϕ₁
    
function potential(f::LinearFaltinse78, x, y, t)

    ϕ₁ = potential₁(f, x, y, t)
    ω = f.ω
    A = f.A
    ϕᶜ = A*x*cos(ω*t)

    return ϕ₁ + ϕᶜ

end

    
                  
    
    
    
