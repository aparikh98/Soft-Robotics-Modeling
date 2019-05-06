data = load('data.mat');
Q = data.part2.bend_angle;
u = data.part2.left_pwm;
gravity = G_gen(Q);
%G + Kq = a * u
X = [gravity, Q];
b = regress(u,X);    % Removes NaN data
alpha = 1/b(1)
K = b(2)/b(1)

