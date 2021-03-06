%Program to adjust current profile to allow investigation of the impact of li
%on the control
%----------------------------------------------------------------
% Includes modification to allow previously modificated jprofile
% equilibria
%----------------------------------------------------------------
%close all
%clear all

%load('/common/projects/physics/MAST-U/Matfiles/2016/conventional_400kA_high_li.mat')
load Super_X_2014_P4_CATIA_400kA;

irod=get(equil, 'irod');
%control=get(equil, 'control');
%feedback=get(equil, 'feedback');
icoil=get(equil, 'icoil');
jprofile=get(equil, 'jprofile');
coilset=get(config, 'coilset');
control = fiesta_control('boundary_method', 2);
control = set(control,'diagnose',0);
control = set(control,'quiet',1);
grid = get(equil, 'grid');

efit_config=fiesta_efit_configuration(grid, inputs, outputs, ...
    free_inputs, relaxation_parameter);

equil_new=fiesta_equilibrium('test', config, irod, ...
							jprofile, control, efit_config, icoil, obs, weights)

%get the values of the j profile at the normalised flux locations
psi_j=linspace(0, 1,100);
psi_z=psi_j;
psi_z(:)=0;
j = get(equil, 'j');
[r, V] = section(j);

%make fiesta sensor to get the j at these points
sens_j=fiesta_sensor_j('jsensor', 'psi_n', psi_j);

j_prof=interp2(equil, sens_j);

%now change the profile and see what the effect is. Have to re-run it through
%the equilibrium so that the normalisation for the current is performed.

%want flat edge on to minimise current outside LCFS - GC says makes compiling
%better
%input alpha (pp) and beta (ff') parameters 
%magnitudes change the profile shape - so more [a,b,c] are entered for each
%with these being the coeffs infront of the polynomial for the curve
%Larger coeffs at higher coeffs gives more current in the outer part of the 
%profile - lower li in theory.

%the alpha values affect the pressure, so the beta of the plasma is determined
%by these - they need to be 1e6 or so larger than the beta values
%conserve the beta poloidal between all of the configurations.

Ip = 400e3;

dos_a =     [0.5,   1,      2]  *0.4e6;
tres_a =    [0.25,  1.5,    3]  *0.33e6;
cuatro_a =  [1,     1,      1]  *0.65e6;
cinco_a =   [4,     2,      1]  *0.75e6;
seis_a =    [4,     2       ]   *1.0e6;
siete_a =   [0.1,   0.1     ]   *1.75e6;

dos_b =     [0.25,  0.5,    1];
tres_b =    [0.25,  0.5,    1.];
cuatro_b=   [0.5,   0.5,    0.5];
cinco_b =   [2,     1,      0.5];
seis_b =    [2,     1];
siete_b =   [0.1,   0.1];

jprofile2=fiesta_jprofile_lao('testj2', dos_a, dos_b, 1, Ip);
equil_j2=fiesta_equilibrium('test2', config, irod, ...
							jprofile2, control, efit_config, icoil, obs, weights)
j_prof2=interp2(equil_j2, sens_j);


jprofile3=fiesta_jprofile_lao('testj3', tres_a, tres_b, 1, Ip);
equil_j3=fiesta_equilibrium('test3', config, irod, ...
							jprofile3, control, efit_config, icoil, obs, weights)
j_prof3=interp2(equil_j3, sens_j);


jprofile4=fiesta_jprofile_lao('testj4', cuatro_a, cuatro_b, 1, Ip);
equil_j4=fiesta_equilibrium('test4', config, irod, ...
							jprofile4, control, efit_config, icoil, obs, weights)
j_prof4=interp2(equil_j4, sens_j);

jprofile5=fiesta_jprofile_lao('testj5', cinco_a, cinco_b, 1, Ip);
equil_j5=fiesta_equilibrium('test5', config, irod, ...
							jprofile5, control, efit_config, icoil, obs, weights)
j_prof5=interp2(equil_j5, sens_j);

jprofile6=fiesta_jprofile_lao('testj6', seis_a, seis_b, 1, Ip);
equil_j6=fiesta_equilibrium('test6', config, irod, ...
							jprofile6, control, efit_config, icoil, obs, weights)
j_prof6=interp2(equil_j6, sens_j);

jprofile7=fiesta_jprofile_lao('testj7', siete_a, siete_b, 1, Ip);
equil_j7=fiesta_equilibrium('test7', config, irod, ...
							jprofile7, control, efit_config, icoil, obs, weights)
j_prof7=interp2(equil_j7, sens_j);