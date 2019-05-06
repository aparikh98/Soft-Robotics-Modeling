function [error] = alpha_k_cost_function(alpha, K, u, g, q)

error = alpha * u - (K * q +g);

end

