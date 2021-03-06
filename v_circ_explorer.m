function [icoil_total]=v_circ_explorer(equil, coilset, smatrix, dI, n)

icoil_orig=get(equil, 'icoil');
icoil_flux=icoil_orig;
icoil_total=icoil_orig;
param_var=smatrix(n, :)';
irod=get(equil, 'irod');

mixer=zeros(get(coilset, 'n'), 3);
mixer([coilset.p4, coilset.p5, coilset.px, coilset.d1, coilset.d2,...
    coilset.d3, coilset.d5, coilset.d6, coilset.d7, coilset.dp, ...
    coilset.pc], 1)=param_var*dI;
mixer(coilset.p1, 2)=1;
mixer(coilset.p6, 3)=1;

coilset_orig=coilset;
coilset=set(coilset, 'matrix', mixer);
icoil_mix=fiesta_icoil(coilset);
icoil_mix.M1=1;
icoil_mix.p1=icoil_orig.p1;
icoil_mix.p6=icoil_orig.p6;

icoil_in=fiesta_icoil(coilset_orig, get(icoil_mix, 'currents')*mixer');

icoil_total=icoil_orig+icoil_in;
icoil_total.p1=icoil_orig.p1;
icoil_total.p6=icoil_orig.p6;
test_i_limits(icoil_total);