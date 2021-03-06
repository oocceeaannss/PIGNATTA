grid=fiesta_grid(1.0, 2.0, 2^5+1, -1.0, 1.0, 2^6+1);
coilset=newcoils_tokamak;
config=fiesta_configuration('Demo', grid, coilset);
figure(config), axes(coilset), plot(coilset);
jprofile=fiesta_jprofile_lao('generic', 1e6);
control=fiesta_control('boundary_method', 1);
irod=10;
icoil=fiesta_icoil(coilset);
icoil.bv=-1.4e4;
equil=fiesta_equilibrium('Demo', config, irod, jprofile, control, [], icoil);
if converged(equil)
    plot(equil), parametersshow(equil)
end