l = size(readtable('../data/part1/pwm0.csv'));
data0 = importdata('../data/part1/pwm0.csv', 50, l(1));
l = size(readtable('../data/part1/pwm100.csv'));
data1 = importdata('../data/part1/pwm100.csv', 50, l(1));
l = size(readtable('../data/part1/pwm225.csv'));
data2 = importdata('../data/part1/pwm225.csv', 50, l(1));

C = vertcat(data0, data1, data2);
angle2 = tan((C.tip_pos_y - C.base_pos_y)./(C.tip_pos_x-C.base_pos_x));
plot(C.left_pwm, angle2)