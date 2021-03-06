%analyse the effect of a virtual circuit on different equilbria and control
%parameters

%caclulate the actual change in coordinate the of the control points
clear all
%close all

%first read back in the sensitivity matrix for a given config
sfile='smatrix_400kA_conv_low_li.txt';
%sfile='smatrix_400kA_conv_highli.txt';
data=importdata(sfile, ' ', 1);

smatrix=data.data;
control_params=char(data.textdata(2:end));
ncontrol=size(control_params, 1);
coil_ind_s={'p4', 'p5', 'px', 'd1', 'd2', 'd3', 'd5', 'd6', 'd7', 'dp', 'pc'};

%read in the equilbria
%equilibria='/projects/physics/MAST-U/Matfiles/2016/conventional_400kA.mat';
%equilibria='/projects/physics/MAST-U/Matfiles/2016/conventional_400kA_high_li.mat';
equilibria='/projects/physics/MAST-U/Matfiles/2016/Super_X_2014_P4_CATIA.mat';
%equilibria='/projects/physics/MAST-U/Matfiles/2016/high_li_sxd_2014coils.mat';
%equilibria='/projects/physics/MAST-U/Matfiles/2016/Conventional_2014_P4_CATIA.mat';
load(equilibria)
equil_orig=equil;
coilset = get(config,'coilset');
control = get(equil,'control');
control = set(control,'diagnose',0);
control = set(control,'quiet',1);

control_points=['mid_in ','mid_out ','xp_low ', 'xp_up ','sp_in_low ', 'sp_out_low ','sp_in_up ','sp_out_up'];
[x_control, y_control, conn_len]=control_pointsV3(equil_orig);
delta=zeros(ncontrol,numel(x_control));
delta_vc=zeros(ncontrol,numel(x_control));
%==============================================================================
%plot the results of the control points
%plot(equil)
%plot(config)
%plotmastuoutline
%plot(x_control, y_control, 'ro')
%==============================================================================
%calculate a delta_psi using the virtual circuit at each control point
%convert to a distance using delta_psi=2piBdelta -> rearrange for delta
%need to do this for each control circuit
% Isoflux sensor
iso = fiesta_sensor_isoflux('fbz_iso', [0.9,  0.9], [1.3, -1.3]);
% v_circ: *equil*, *coilset*, *dI*, *control parameter*
[icoil_total]=v_circ(equil, coilset, smatrix, 1, 1);

for i=1

    % Introduce feedback
	feedback=fiesta_feedback2(get(config,'grid'), coilset, ...
							'p6', iso);  % P6 has the feedback control
	equil_new=set(equil,config,'feedback',feedback,'control',control);
	equil_new=set(equil_new,config,'icoil',icoil_total);

	%now find the location of the control points in the new equil
	[x_control_vc, y_control_vc, conn_len_vc]=control_pointsV3(equil_new);
	%calculate the change in the location of the control points
	delta_x=x_control-x_control_vc;
	delta_y=abs(y_control)-abs(y_control_vc); %kludge
	delta_vc(i,:)=sqrt(delta_x.^2+delta_y.^2);
end

% Write the result in delta_vc to a file
fid=fopen('analyse_vc_out.txt', 'w');

fprintf(fid, '%s\n', equilibria);
fprintf(fid, '%s\n', sfile);
fprintf(fid, '%s', 'delta_pos(m) ');
fprintf(fid, '%s', control_points);
fprintf(fid, '%s\n', ' ');

for i=1:ncontrol
	fprintf(fid, '%s', control_params(i,:));
	for j=1:numel(x_control)
		if j < numel(x_control)
			fprintf(fid, ' %f', delta_vc(i,j));
		end
		if j == numel(x_control)
			fprintf(fid, ' %f\n', delta_vc(i,j));
		end
	end
end
fclose(fid);

%plot the result and check the location of the control points is correct
hold on
plot(equil_orig, 'psi_boundary', 'b')
plot(equil_new, 'psi_boundary', 'r') 
plotmastuoutline
plot(config)
plot(x_control, y_control, 'ob')
plot(x_control_vc, y_control_vc, 'xr')
conn_len
conn_len_vc

%reculate the equilbrium with the extra VC circuit current added
%icoil_total=icoil_orig;
%for ii=1:11
%	icoil_total.(char(coil_ind_s{ii}))=icoil_orig.(char(coil_ind_s{ii}))+... 
%											smatrix(i,ii)*dI;
%end
