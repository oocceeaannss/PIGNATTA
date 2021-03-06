% Script to plot results of studies about Li in MAST-U
% to be used with the modified version of test_jprofile and 
% test_jprofile_boundary
% ------------------------------Plot all equilibria boundaries using colors
figure('Units','normalized','PaperPositionMode','auto');
plot(equil_new, 'psi_boundary', 'k')
plot(equil_j2, 'psi_boundary', 'r')
plot(equil_j3, 'psi_boundary', 'b')
plot(equil_j4, 'psi_boundary', 'g')
plot(equil_j5, 'psi_boundary', 'c')
plot(equil_j6, 'psi_boundary', 'm')
plot(equil_j7, 'psi_boundary', 'y')
legend('new', 'j2', 'j3', 'j4', 'j5', 'j6', 'j7', 'location', 'se')

% --------------------------------Plot the current profiles at the midplane
figure('Units','normalized','PaperPositionMode','auto'); 
j = get(equil_new, 'j');
j2 = get(equil_j2, 'j');
j3 = get(equil_j3, 'j');
j4 = get(equil_j4, 'j');
j5 = get(equil_j5, 'j');
j6 = get(equil_j6, 'j');
j7 = get(equil_j7, 'j');
section(j3);
hold on
[r, v] = section(j);
[r, vj2] = section(j2);
[r, vj4] = section(j4);
[r, vj5] = section(j5);
[r, vj6] = section(j6);
[r, vj7] = section(j7);
plot(r,v, 'k')
plot(r, vj2, 'r')
plot(r, vj4, 'g')
plot(r, vj5, 'c')
plot(r, vj6, 'm')
plot(r, vj7, 'y')
legend('j3', 'new', 'j2', 'j4', 'j5', 'j6', 'j7', 'location', 'se')
xlabel('r (m)')
ylabel('J (A)')

% ----------------------------------Plot the current profiles from psi_zero
figure('Units','normalized','PaperPositionMode','auto');  
plot(psi_j, j_prof, 'k')
hold on
plot(psi_j, j_prof2, 'r')
plot(psi_j, j_prof3, 'b')
plot(psi_j, j_prof4, 'g')
plot(psi_j, j_prof5, 'c')
plot(psi_j, j_prof6, 'm')
plot(psi_j, j_prof7, 'y')
legend('new', 'j2', 'j3', 'j4', 'j5', 'j6', 'j7')
xlabel('$\psi_{n}$', 'interpreter', 'latex', 'fontsize', 19)
ylabel('J (A)')

% --------------------Plot changes in internal inductance and poloidal beta
figure('Units','normalized','PaperPositionMode','auto'); 
plot([li(equil_new), li(equil_j2), li(equil_j3), li(equil_j4), li(equil_j5), li(equil_j6), li(equil_j7)])
hold on
plot([betap(equil_new), betap(equil_j2), betap(equil_j3), betap(equil_j4), betap(equil_j5), betap(equil_j6), betap(equil_j7)], 'r')
legend('internal inductance', 'poloidal beta')
xlabel('Profile number')
ylabel('Magnitude')

% -----------------------------------Plot evolution of coefficients (ALPHA)
figure('Units','normalized','PaperPositionMode','auto');  
plot([uno_a(1), dos_a(1), tres_a(1), cuatro_a(1), cinco_a(1), ...
    seis_a(1), siete_a(1)], 'ro')
hold on
plot([uno_a(2), dos_a(2), tres_a(2), cuatro_a(2), cinco_a(2), ...
    seis_a(2), siete_a(2)], 'bx')
plot([uno_a(3), dos_a(3), tres_a(3), cuatro_a(3), cinco_a(3), ...
    seis_a(3), siete_a(3)], 'g.')
plot([uno_a(4), dos_a(4), tres_a(4), cuatro_a(4), cinco_a(4), ...
    seis_a(4), siete_a(4)], 'm+')
legend('1st', '2nd', '3rd', '4th', 'location', 'se')
plot([uno_a(1), dos_a(1), tres_a(1), cuatro_a(1), cinco_a(1), ...
    seis_a(1), siete_a(1)], 'r')
plot([uno_a(2), dos_a(2), tres_a(2), cuatro_a(2), cinco_a(2), ...
    seis_a(2), siete_a(2)], 'b')
plot([uno_a(2), dos_a(3), tres_a(3), cuatro_a(3), cinco_a(3), ...
    seis_a(3), siete_a(3)], 'g')
plot([uno_a(4), dos_a(4), tres_a(4), cuatro_a(4), cinco_a(4), ...
    seis_a(4), siete_a(4)], 'm')
title('Alpha coefficient')
xlabel('Profile number')
ylabel('Magnitude')

% ------------------------------------Plot evolution of coefficients (BETA)
figure('Units','normalized','PaperPositionMode','auto');
plot([uno_b(1), dos_b(1), tres_b(1), cuatro_b(1), cinco_b(1), ...
    seis_b(1), siete_b(1)], 'ro')
hold on
plot([uno_b(2), dos_b(2), tres_b(2), cuatro_b(2), cinco_b(2), ...
    seis_b(2), siete_b(2)], 'bx')
plot([uno_b(3), dos_b(3), tres_b(3), cuatro_b(3), cinco_b(3), ...
    seis_b(3), siete_b(3)], 'g.')
plot([uno_b(4), dos_b(4), tres_b(4), cuatro_b(4), cinco_b(4), ...
    seis_b(4), siete_b(4)], 'm+')
legend('1st', '2nd', '3rd', '4th', 'location', 'se')
plot([uno_b(1), dos_b(1), tres_b(1), cuatro_b(1), cinco_b(1), ...
    seis_b(1), siete_b(1)], 'r')
plot([uno_b(2), dos_b(2), tres_b(2), cuatro_b(2), cinco_b(2), ...
    seis_b(2), siete_b(2)], 'b')
plot([uno_b(2), dos_b(3), tres_b(3), cuatro_b(3), cinco_b(3), ...
    seis_b(3), siete_b(3)], 'g')
plot([uno_b(4), dos_b(4), tres_b(4), cuatro_b(4), cinco_b(4), ...
    seis_b(4), siete_b(4)], 'm')
title('Beta coefficient')
xlabel('Profile number')
ylabel('Magnitude')

% --------------------------------Coil currents as Li changes (02/08 modif)
figure('Units','normalized','PaperPositionMode','auto');
icoil_new = get(equil_new, 'icoil');
Li = [li(equil_new), li(equil_j2), li(equil_j3), li(equil_j4), ...
    li(equil_j5), li(equil_j6), li(equil_j7)];
for i=2:7
    eval([sprintf('icoil_j%d', i) '=get(equil_' sprintf('j%d, ''icoil'');', i)])
end
p1 = [icoil_new.p1, icoil_j2.p1, icoil_j3.p1, icoil_j4.p1, ...
    icoil_j5.p1, icoil_j6.p1, icoil_j7.p1];
p4 = [icoil_new.p4, icoil_j2.p4, icoil_j3.p4, icoil_j4.p4, ...
    icoil_j5.p4, icoil_j6.p4, icoil_j7.p4];
p5 = [icoil_new.p5, icoil_j2.p5, icoil_j3.p5, icoil_j4.p5, ...
    icoil_j5.p5, icoil_j6.p5, icoil_j7.p5];
px = [icoil_new.px, icoil_j2.px, icoil_j3.px, icoil_j4.px, ...
    icoil_j5.px, icoil_j6.px, icoil_j7.px];
d1 = [icoil_new.d1, icoil_j2.d1, icoil_j3.d1, icoil_j4.d1, ...
    icoil_j5.d1, icoil_j6.d1, icoil_j7.d1];
d2 = [icoil_new.d2, icoil_j2.d2, icoil_j3.d2, icoil_j4.d2, ...
    icoil_j5.d2, icoil_j6.d2, icoil_j7.d2];
d3 = [icoil_new.d3, icoil_j2.d3, icoil_j3.d3, icoil_j4.d3, ...
    icoil_j5.d3, icoil_j6.d3, icoil_j7.d3];
d5 = [icoil_new.d5, icoil_j2.d5, icoil_j3.d5, icoil_j4.d5, ...
    icoil_j5.d5, icoil_j6.d5, icoil_j7.d5];
d6 = [icoil_new.d6, icoil_j2.d6, icoil_j3.d6, icoil_j4.d6, ...
    icoil_j5.d6, icoil_j6.d6, icoil_j7.d6];
d7 = [icoil_new.d7, icoil_j2.d7, icoil_j3.d7, icoil_j4.d7, ...
    icoil_j5.d7, icoil_j6.d7, icoil_j7.d7];
dp = [icoil_new.dp, icoil_j2.dp, icoil_j3.dp, icoil_j4.dp, ...
    icoil_j5.dp, icoil_j6.dp, icoil_j7.dp];
pc = [icoil_new.pc, icoil_j2.pc, icoil_j3.pc, icoil_j4.pc, ...
    icoil_j5.pc, icoil_j6.pc, icoil_j7.pc];
plot(Li,p4,'o', Li,p5,'o', Li,d1,'o', Li,d2,'o', Li,d3,'o', ...
    Li,d5,'o', Li,d6,'o', Li,d7,'o', Li,dp,'o', Li,pc,'o')

  
figure('Units','normalized','PaperPositionMode','auto');
Lo_SXD1MA_d1_free = sortrows([Li;d1]', 1)';
Lo_SXD1MA_d2_free = sortrows([Li;d2]', 1)';
Lo_SXD1MA_d3_free = sortrows([Li;d3]', 1)';
Lo_SXD1MA_dp_free = sortrows([Li;dp]', 1)';
Lo_SXD1MA_d5_free = sortrows([Li;d5]', 1)';
Lo_SXD1MA_d6_free = sortrows([Li;d6]', 1)';
Lo_SXD1MA_d7_free = sortrows([Li;d7]', 1)';
Lo_SXD1MA_p4_free = sortrows([Li;p4]', 1)';
Lo_SXD1MA_p1_free = sortrows([Li;p1]', 1)';

plot(Lo_SXD1MA_d1_free(1, :), Lo_SXD1MA_d1_free(2, :), '-')
hold on
%plot(Lo_SXD1MA_d1(1, :), Lo_SXD1MA_d1(2, :), '--')
plot(Lo_SXD1MA_d2_free(1, :), Lo_SXD1MA_d2_free(2, :), 'r-')
%plot(Lo_SXD1MA_d2(1, :), Lo_SXD1MA_d2(2, :), 'r--')
plot(Lo_SXD1MA_d3_free(1, :), Lo_SXD1MA_d3_free(2, :), 'g-')
%plot(Lo_SXD1MA_d3(1, :), Lo_SXD1MA_d3(2, :), 'g--')
plot(Lo_SXD1MA_dp_free(1, :), Lo_SXD1MA_dp_free(2, :), 'm-')
plot(Lo_SXD1MA_p1_free(1, :), Lo_SXD1MA_d1_free(2, :), 'k-')
%legend('d1 all-free', 'd1', 'd2 all-free', 'd2', 'd3 all-free', ...
%    'd3', 'dp all-free', 'dp', 'p1 all-free', 'p1 -20kA')
legend('d1', 'd2', 'd3', 'dp', 'p1')
ylabel('Current in coil (A)')
xlabel('Li')
figure();
plot(Lo_SXD1MA_d5_free(1, :), Lo_SXD1MA_d5_free(2, :), '-')
hold on
%plot(Lo_SXD1MA_d5(1, :), Lo_SXD1MA_d5(2, :), '--')
plot(Lo_SXD1MA_d6_free(1, :), Lo_SXD1MA_d6_free(2, :), 'r-')
%plot(Lo_SXD1MA_d6(1, :), Lo_SXD1MA_d6(2, :), 'r--')
plot(Lo_SXD1MA_d7_free(1, :), Lo_SXD1MA_d7_free(2, :), 'g-')
%plot(Lo_SXD1MA_d7(1, :), Lo_SXD1MA_d7(2, :), 'g--')
plot(Lo_SXD1MA_p4_free(1, :), Lo_SXD1MA_p4_free(2, :), 'm-')
%plot(Lo_SXD1MA_p4(1, :), Lo_SXD1MA_p4(2, :), 'm--')
%legend('d5 all-free', 'd5', 'd6 all-free', 'd6', 'd7 all-free', ...
%    'd7', 'p4 all-free', 'p4')
legend('d5', 'd6', 'd7', 'p4')
ylabel('Current in coil (A)')
xlabel('Li')



figure('Units','normalized','PaperPositionMode','auto');  % Plot control points displacements
con = linspace(2, 7, 6);
[x_new, y_new, conn_new] = control_pointsV3(equil_new);
for i=2:7
    eval(['[' sprintf('x_j%d,', i) sprintf('y_j%d,', i) ...
        sprintf('cl_j%d', i) ']' '=' ...
        sprintf('control_pointsV3(equil_j%d);', i)]);
  
    eval([sprintf('d_%d = (', i) sprintf('(x_j%d-x_new).^2+', i) sprintf('(y_j%d-y_new).^2).^(0.5);', i)]);
    imp(i-1) = eval(sprintf('d_%d(1);', i));
    omp(i-1) = eval(sprintf('d_%d(2);', i));
    xpoint(i-1) = eval(sprintf('d_%d(3);', i));
    isp(i-1) = eval(sprintf('d_%d(5);', i));
    osp(i-1) = eval(sprintf('d_%d(6);', i));
end
plot(con, imp, con, omp, con, isp, con, osp)
legend('Inner midplane', 'Outer midplane', 'Inner strike point', 'Outer strike point')
ylabel('Displacement (cm)')
xlabel('Profile number')