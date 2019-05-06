function [error] = hyper_elastic_C_cost(C1, C2, alpha, u, gravity, Q)

lambda = Q ./ sin(Q);
sigma = (lambda ^4 -1) * 1/lambda ^3 * (2 * C1 + 4 * C2 * (lambda - 1/lambda) ^2);
K = sigma ./ lambda;
%a * u = K * q + G
error = alpha * u - K * Q - gravity;

end

