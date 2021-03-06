figure;
vfile0 = 'THE_other';
vdata0 = importdata(vfile0, ' ', 0);
vdata0 = vdata0.data;
p4 = vdata0(:, 1);
p5 = vdata0(:, 2);
px = vdata0(:, 3);
d1 = vdata0(:, 4);
d2 = vdata0(:, 5);
d3 = vdata0(:, 6);
d5 = vdata0(:, 7);
d6 = vdata0(:, 8);
d7 = vdata0(:, 9);
dp = vdata0(:, 10);
pc = vdata0(:, 11);
plot(linspace(1,55, 12), [p4(1:12), p5(1:12), px(1:12), d1(1:12), d2(1:12), d3(1:12), d5(1:12)])
hold on
plot(linspace(1,55, 12), [d6(1:12), d7(1:12), dp(1:12), pc(1:12)], '.')
legend(coil_ind_s, 'location', 'nw', 'FontSize', 7)
plot(linspace(1,55, 12), [d6(1:12), d7(1:12), dp(1:12), pc(1:12)], '-')
title('Coil behaviour SD to SXD')
ylabel('dI (A)')
xlabel('Displacement (cm)')
print('coil_behaviour', '-dpng')
print('coil_behaviour', '-dpng')

figure;
vfile0 = 'THE_sxd_1MA_lowli.txt';
vdata0 = importdata(vfile0, ' ', 0);
vdata0 = vdata0.data;
p4 = vdata0(:, 1);
p5 = vdata0(:, 2);
px = vdata0(:, 3);
d1 = vdata0(:, 4);
d2 = vdata0(:, 5);
d3 = vdata0(:, 6);
d5 = vdata0(:, 7);
d6 = vdata0(:, 8);
d7 = vdata0(:, 9);
dp = vdata0(:, 10);
pc = vdata0(:, 11);
plot(-linspace(1,45, 12), [p4(1:12), p5(1:12), px(1:12), d1(1:12), d2(1:12), d3(1:12), d5(1:12)])
hold on
plot(-linspace(1,45, 12), [d6(1:12), d7(1:12), dp(1:12), pc(1:12)], '.')
%legend(coil_ind_s, 'location', 'nw', 'FontSize', 7)
plot(-linspace(1,45, 12), [d6(1:12), d7(1:12), dp(1:12), pc(1:12)], '-')
title('Coil behaviour SXD to SD')
ylabel('dI (A)')
xlabel('Displacement (cm)')
print('coil_behaviour', '-dpng')
print('coil_behaviour', '-dpng')
