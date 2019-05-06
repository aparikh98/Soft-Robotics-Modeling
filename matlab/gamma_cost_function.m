function [error] = gamma_cost_function(gamma, beta, pressure, d_pressure, d_pressure2, u)

error = beta * u - (gamma * gamma * d_pressure2 + gamma * 2 * d_pressure + pressure);

end

