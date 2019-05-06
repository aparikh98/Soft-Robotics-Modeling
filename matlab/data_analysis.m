clear all
close all
clc

%% Package paths

cur = pwd;
addpath( genpath( [cur, '/gen/' ] ));

%% Load CSV run import data, Generate q(t)

data = part2beta;
Q = data.bend_angle;
% This section is done in python in: readcsv.ipynb. We vary parameters
% within the notebook to 


%% do your regression
u = data.left_pwm; 
gravity = G_gen(Q);
%au - KQ = gravity
C = [u -1 * Q];
d = gravity;
A = [-1 -1];
b = -0.1;

[x,resnorm,residual,exitflag,output,lambda] = lsqlin(C,d, A, b);
alpha = x(1)
k = x(2)
resnorm


%% calculate gamma based on pressure
len = size(data.time);
len = len(1);

u = data.left_pwm;
pressure = data.left_pressure;
d_pressure = zeros(size(data.time));
d_pressure2 = zeros(size(data.time));

for index = 2: len -1
    if data.time(index) > data.time(index -1) &&  data.time(index) < data.time(index + 1) %check to make sure its part of the same run...
        d_pressure(index) = (pressure(index + 1) - pressure(index - 1)) /  (data.time(index +1) - data.time(index - 1));
    end
end

for index = 2: len -1 
    if data.time(index) > data.time(index -1) &&  data.time(index) < data.time(index + 1)
        d_pressure2(index) = (d_pressure(index + 1) - d_pressure(index - 1)) /  (data.time(index +1) - data.time(index - 1));
    end

end

gammacost = @(x) gamma_cost_function(x(1), x(2), pressure, d_pressure, d_pressure2, u);

[results,resnorm] = lsqnonlin(gammacost, [1, 1])
gamma = results(1)
beta = results(2)

%% 
delta_vals = 0.1:0.1:2;
gamma_vals = 0.1:0.1:2;
len = size(delta_vals);
len = len(2);
values = [];
for index = 1:len
    for index2 = 1:len
        delta = delta_vals(index);
        gamma = gamma_vals(index);
        t = data.time(1:20);
        u = data.left_pwm(1:20);
        q = data.bend_angle(1:20);
        q0 = 0;
        dq0 = 0;

        tau0 = 0;
        dtau0 = 0;

        % x = [K, D, alpha, gamma]

        cost = @(x) cost_function(x(1), x(2), x(3), x(4), t, u, q, q0, dq0, tau0, dtau0);


        [results, resnorm] = lsqnonlin(cost, [k  ,  delta  , alpha   , gamma])
        values = [values results];
    end
end
%% Model 2 Calculate C1, C2

cost = @(x) hyper_elastic_C_cost(x(1), x(2), alpha, u, gravity, Q)


[results, resnorm] = lsqnonlin(cost, [0, 0])

C1 = results(1)
C2 = results(2)

lambda = Q / sin(Q);
sigma = (lambda ^4 -1)/ lambda ^3 * (2 * C1 + 4 * C2 * (lambda - 1/lambda) ^2);
K = sigma /lambda;


%% Evaluate again:
delta_vals = 0.1:0.1:2;
len = size(delta_vals);
len = len(2);
values = [];
for index = 1:len
    delta = delta_vals(index);
    t = data.time(1:20);
    u = data.left_pwm(1:20);
    q = data.bend_angle(1:20);
    q0 = 0;
    dq0 = 0;

    tau0 = 0;
    dtau0 = 0;

    % x = [K, D, alpha, gamma]

    %use second cost function
    cost = @(x) cost_function2(x(1), x(2), x(3), x(4), t, u, q, q0, dq0, tau0, dtau0, C1, C2);

    %use calculated K, gamma and alpha from first model 
    [results, resnorm] = lsqnonlin(cost, [K  ,  delta  , alpha   , gamma])
    values = [values results];
end




