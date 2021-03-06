% Program to analise current variations in terms of dismplacement (can be
% used for a sensitivity matrix or just a coil

%clear all

%first read back in the sensitivity matrix for a given config
path = '/home/cmoreno/work/smats_SXD_1MA/';
sfile=[path, 'smat1.txt'];
sfile5=[path, 'smat5.txt'];
sfile10=[path, 'smat10.txt'];
sfile15=[path, 'smat15.txt'];
sfile18=[path, 'smat18.txt'];
sfile25=[path, 'smat25.txt'];
sfile30=[path, 'smat30.txt'];
sfile35=[path, 'smat35.txt'];
sfile40=[path, 'smat40.txt'];
sfile45=[path, 'smat45.txt'];
sfile50=[path, 'smat50.txt'];
%sfile55=[path, 'smat55.txt'];
%sfile60=[path, 'smat60.txt'];
%sfile65=[path, 'smat65.txt'];
%sfile70=[path, 'smat70.txt'];
%sfile75=[path, 'smat75.txt'];
%sfile80=[path, 'smat80.txt'];
array = [1, 5, 10, 15, 18, 25, 30, 35, 40, 45, 50];
data1=importdata(sfile, ' ', 1);
data5=importdata(sfile5, ' ', 1);
data10=importdata(sfile10, ' ', 1);
data15=importdata(sfile15, ' ', 1);
data18=importdata(sfile18, ' ', 1);
data25=importdata(sfile25, ' ', 1);
data30=importdata(sfile30, ' ', 1);
data35=importdata(sfile35, ' ', 1);
data40=importdata(sfile40, ' ', 1);
data45=importdata(sfile45, ' ', 1);
data50=importdata(sfile50, ' ', 1);
%data55=importdata(sfile55, ' ', 1);
%data60=importdata(sfile60, ' ', 1);
%data65=importdata(sfile65, ' ', 1);
%data70=importdata(sfile70, ' ', 1);
%data75=importdata(sfile75, ' ', 1);
%data80=importdata(sfile80, ' ', 1);

%sfile0='smatrices/smatrix_400kA_conv_low_li.txt';  % Original smatrix SD
%data0=importdata(sfile0, ' ', 1);

%read in the equilbria
%equilibria='/projects/physics/MAST-U/Matfiles/2016/conventional_400kA.mat';
%equilibria='/projects/physics/MAST-U/Matfiles/2016/conventional_400kA_high_li.mat';
%equilibria='/projects/physics/MAST-U/Matfiles/2016/Super_X_2014_P4_CATIA.mat';
%equilibria='/projects/physics/MAST-U/Matfiles/2016/high_li_sxd_2014coils.mat';
%equilibria='/projects/physics/MAST-U/Matfiles/2016/Conventional_2014_P4_CATIA.mat';
%load Conventional_2014_P4_CATIA_400kA;
%equil=equil_j2;

coilset = get(config,'coilset');
control = get(equil,'control');
control = set(control,'diagnose',0);
control = set(control,'quiet',1);

[x_control, y_control, conn_len]=control_pointsV3(equil);
% Isoflux sensor
iso = fiesta_sensor_isoflux('fbz_iso', [0.9,  0.9], [1.3, -1.3]);
icoil_orig=get(equil, 'icoil');
icoil_flux=icoil_orig;
che = 0;  % initializes determinator of config and mastoutline plot
path = '/home/cmoreno/work/equil_displacements/SXDtoCD/original/';
for i=1
    eval(sprintf('smatrix=data%d.data;', i))  %-----------------------------------------------------

    for displ=0:50
        displ=-displ
        for control_p=6
            %calculate the change in the location of the control points
            [icoil_total]=v_circ_explorer(equil, coilset, smatrix, displ, control_p);

            % Introduce feedback & calculate first new equilibrium
            feedback=fiesta_feedback2(get(config,'grid'), coilset, 'p6', iso);
            equil_new=set(equil,config,'feedback',feedback,'control',control);
            equil_new=set(equil_new,config,'icoil',icoil_total);
            [x_control_vc, y_control_vc, conn_len_vc]=control_pointsV3(equil_new);

            delta_x=x_control-x_control_vc;
            delta_y=abs(y_control)-abs(y_control_vc); %kludge for when the xpts are other way up
            delta_vc(control_p,:)=sqrt(delta_x.^2+delta_y.^2);
            params=parameters(equil_new);
            betap=params.betap;

            eval(sprintf('vals=fopen([path, ''dummy%d.txt''], ''a'');', i))  %--------------------------
            fprintf(vals, '%f', displ);
            fprintf(vals, ' %f', conn_len_vc(1));
            fprintf(vals, ' %f', conn_len_vc(3));
            for j=1:numel(x_control)
                if j < numel(x_control)
                    fprintf(vals, ' %f', delta_x(j));
                end
                if j == numel(x_control)
                 fprintf(vals, ' %f\n', delta_x(j));
                end
            end
            fclose(vals);

            plot(equil_new, 'psi_boundary', 'r') 
            if che==0
                hold on
                plot(equil, 'psi_boundary', 'b')
                plotmastuoutline;
                plot(config)        
            end 
            che = che + 1;
        end
    end
end