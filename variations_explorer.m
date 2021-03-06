% Program to analise current variations in terms of dismplacement (can be
% used for a sensitivity matrix or just a coil

clear all

%first read back in the sensitivity matrix for a given config
%sfile='smatrix_400kA_conv_low_li.txt';
%sfile='smatrix_1MA_SXD_low_li.txt';
%sfile='smatrix_400kA_conv_highli.txt';
sfile='smatrix_dummy.txt';
data=importdata(sfile, ' ', 1);

smatrix=data.data;
control_params=char(data.textdata(2:end));
ncontrol=size(control_params, 1);
coil_ind_s={'p4', 'p5', 'px', 'd1', 'd2', 'd3', 'd5', 'd6', 'd7', 'dp', 'pc'};

%read in the equilbria
%equilibria='/projects/physics/MAST-U/Matfiles/2016/conventional_400kA.mat';
%equilibria='/projects/physics/MAST-U/Matfiles/2016/conventional_400kA_high_li.mat';
%equilibria='/projects/physics/MAST-U/Matfiles/2016/Super_X_2014_P4_CATIA.mat';
%equilibria='/projects/physics/MAST-U/Matfiles/2016/high_li_sxd_2014coils.mat';
equilibria='/projects/physics/MAST-U/Matfiles/2016/Conventional_2014_P4_CATIA.mat';
load(equilibria)
equil_orig=equil;
irod=get(equil, 'irod');
control_points=['mid_in ','mid_out ','xp_low ', 'xp_up ','sp_in_low ', 'sp_out_low ','sp_in_up ','sp_out_up'];

coilset = get(config,'coilset');
control = get(equil,'control');
control = set(control,'diagnose',0);
control = set(control,'quiet',1);

[x_control, y_control, conn_len]=control_pointsV30(equil_orig);
% Isoflux sensor
iso = fiesta_sensor_isoflux('fbz_iso', [0.9,  0.9], [1.3, -1.3]);

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

icoil_orig=get(equil, 'icoil');
icoil_flux=icoil_orig;

che = 0;  % initializes determinator of config and mastoutline plot
for displ=-40:40
    for control_p=1
        %calculate the change in the location of the control points
        [icoil_total]=v_circ_explorer(equil, coilset, smatrix, displ, control_p);

        % Introduce feedback & calculate first new equilibrium
        feedback=fiesta_feedback2(get(config,'grid'), coilset, 'p6', iso);
        equil_new=set(equil,config,'feedback',feedback,'control',control);
        equil_new=set(equil_new,config,'icoil',icoil_total);
        [x_control_vc, y_control_vc, conn_len_vc]=control_pointsV30(equil_new);

        delta_x=x_control-x_control_vc;
        delta_y=abs(y_control)-abs(y_control_vc); %kludge for when the xpts are other way up
        delta_vc(control_p,:)=sqrt(delta_x.^2+delta_y.^2);

        vals=fopen('1M.txt', 'a');
        fprintf(vals, '%f', icoil_total.p4);
        for j=1:numel(x_control)
            if j < numel(x_control)
                fprintf(vals, ' %f', delta_vc(control_p,j));
            end
            if j == numel(x_control)
             fprintf(vals, ' %f\n', delta_vc(control_p,j));
            end
        end
        fclose(vals);
        
        plot(equil_new, 'psi_boundary', 'r') 
        if che==0
            hold on
            plot(equil_orig, 'psi_boundary', 'b')
            plotmastuoutline;
            plot(config)        
        end 
        che = che + 1;
    end
end
print('1m', '-dpng');
clf

che = 0;  % initializes determinator of config and mastoutline plot
for displ=-40:40
    for control_p=2
        %calculate the change in the location of the control points
        [icoil_total]=v_circ_explorer(equil, coilset, smatrix, displ, control_p);

        % Introduce feedback & calculate first new equilibrium
        feedback=fiesta_feedback2(get(config,'grid'), coilset, 'p6', iso);
        equil_new=set(equil,config,'feedback',feedback,'control',control);
        equil_new=set(equil_new,config,'icoil',icoil_total);
        [x_control_vc, y_control_vc, conn_len_vc]=control_pointsV30(equil_new);

        delta_x=x_control-x_control_vc;
        delta_y=abs(y_control)-abs(y_control_vc); %kludge for when the xpts are other way up
        delta_vc(control_p,:)=sqrt(delta_x.^2+delta_y.^2);

        vals=fopen('2M.txt', 'a');
        fprintf(vals, '%f', icoil_total.p5);
        for j=1:numel(x_control)
            if j < numel(x_control)
                fprintf(vals, ' %f', delta_vc(control_p,j));
            end
            if j == numel(x_control)
             fprintf(vals, ' %f\n', delta_vc(control_p,j));
            end
        end
        fclose(vals);
        
        plot(equil_new, 'psi_boundary', 'r') 
        if che==0
            hold on
            plot(equil_orig, 'psi_boundary', 'b')
            plotmastuoutline;
            plot(config)        
        end 
        che = che + 1;
    end
end
print('2M', '-dpng');
clf

che = 0;  % initializes determinator of config and mastoutline plot
for displ=-40:40
    for control_p=3
        %calculate the change in the location of the control points
        [icoil_total]=v_circ_explorer(equil, coilset, smatrix, displ, control_p);

        % Introduce feedback & calculate first new equilibrium
        feedback=fiesta_feedback2(get(config,'grid'), coilset, 'p6', iso);
        equil_new=set(equil,config,'feedback',feedback,'control',control);
        equil_new=set(equil_new,config,'icoil',icoil_total);
        [x_control_vc, y_control_vc, conn_len_vc]=control_pointsV30(equil_new);

        delta_x=x_control-x_control_vc;
        delta_y=abs(y_control)-abs(y_control_vc); %kludge for when the xpts are other way up
        delta_vc(control_p,:)=sqrt(delta_x.^2+delta_y.^2);

        vals=fopen('3M.txt', 'a');
        fprintf(vals, '%f', icoil_total.px);
        for j=1:numel(x_control)
            if j < numel(x_control)
                fprintf(vals, ' %f', delta_vc(control_p,j));
            end
            if j == numel(x_control)
             fprintf(vals, ' %f\n', delta_vc(control_p,j));
            end
        end
        fclose(vals);
        
        plot(equil_new, 'psi_boundary', 'r') 
        if che==0
            hold on
            plot(equil_orig, 'psi_boundary', 'b')
            plotmastuoutline;
            plot(config)        
        end 
        che = che + 1;
    end
end
print('3m', '-dpng');
clf
che = 0;  % initializes determinator of config and mastoutline plot
for displ=-40:40
    for control_p=4
        %calculate the change in the location of the control points
        [icoil_total]=v_circ_explorer(equil, coilset, smatrix, displ, control_p);

        % Introduce feedback & calculate first new equilibrium
        feedback=fiesta_feedback2(get(config,'grid'), coilset, 'p6', iso);
        equil_new=set(equil,config,'feedback',feedback,'control',control);
        equil_new=set(equil_new,config,'icoil',icoil_total);
        [x_control_vc, y_control_vc, conn_len_vc]=control_pointsV30(equil_new);

        delta_x=x_control-x_control_vc;
        delta_y=abs(y_control)-abs(y_control_vc); %kludge for when the xpts are other way up
        delta_vc(control_p,:)=sqrt(delta_x.^2+delta_y.^2);

        vals=fopen('4M.txt', 'a');
        fprintf(vals, '%f', icoil_total.d1);
        for j=1:numel(x_control)
            if j < numel(x_control)
                fprintf(vals, ' %f', delta_vc(control_p,j));
            end
            if j == numel(x_control)
             fprintf(vals, ' %f\n', delta_vc(control_p,j));
            end
        end
        fclose(vals);
        
        plot(equil_new, 'psi_boundary', 'r') 
        if che==0
            hold on
            plot(equil_orig, 'psi_boundary', 'b')
            plotmastuoutline;
            plot(config)        
        end 
        che = che + 1;
    end
end
print('4m', '-dpng');
clf

che = 0;  % initializes determinator of config and mastoutline plot
for displ=-40:40
    for control_p=5
        %calculate the change in the location of the control points
        [icoil_total]=v_circ_explorer(equil, coilset, smatrix, displ, control_p);

        % Introduce feedback & calculate first new equilibrium
        feedback=fiesta_feedback2(get(config,'grid'), coilset, 'p6', iso);
        equil_new=set(equil,config,'feedback',feedback,'control',control);
        equil_new=set(equil_new,config,'icoil',icoil_total);
        [x_control_vc, y_control_vc, conn_len_vc]=control_pointsV30(equil_new);

        delta_x=x_control-x_control_vc;
        delta_y=abs(y_control)-abs(y_control_vc); %kludge for when the xpts are other way up
        delta_vc(control_p,:)=sqrt(delta_x.^2+delta_y.^2);

        vals=fopen('5M.txt', 'a');
        fprintf(vals, '%f', icoil_total.d2);
        for j=1:numel(x_control)
            if j < numel(x_control)
                fprintf(vals, ' %f', delta_vc(control_p,j));
            end
            if j == numel(x_control)
             fprintf(vals, ' %f\n', delta_vc(control_p,j));
            end
        end
        fclose(vals);
        
        plot(equil_new, 'psi_boundary', 'r') 
        if che==0
            hold on
            plot(equil_orig, 'psi_boundary', 'b')
            plotmastuoutline;
            plot(config)        
        end 
        che = che + 1;
    end
end
print('5M', '-dpng');
clf

che = 0;  % initializes determinator of config and mastoutline plot
for displ=-40:40
    for control_p=6
        %calculate the change in the location of the control points
        [icoil_total]=v_circ_explorer(equil, coilset, smatrix, displ, control_p);

        % Introduce feedback & calculate first new equilibrium
        feedback=fiesta_feedback2(get(config,'grid'), coilset, 'p6', iso);
        equil_new=set(equil,config,'feedback',feedback,'control',control);
        equil_new=set(equil_new,config,'icoil',icoil_total);
        [x_control_vc, y_control_vc, conn_len_vc]=control_pointsV30(equil_new);

        delta_x=x_control-x_control_vc;
        delta_y=abs(y_control)-abs(y_control_vc); %kludge for when the xpts are other way up
        delta_vc(control_p,:)=sqrt(delta_x.^2+delta_y.^2);

        vals=fopen('6M.txt', 'a');
        fprintf(vals, '%f', icoil_total.d3);
        for j=1:numel(x_control)
            if j < numel(x_control)
                fprintf(vals, ' %f', delta_vc(control_p,j));
            end
            if j == numel(x_control)
             fprintf(vals, ' %f\n', delta_vc(control_p,j));
            end
        end
        fclose(vals);
        
        plot(equil_new, 'psi_boundary', 'r') 
        if che==0
            hold on
            plot(equil_orig, 'psi_boundary', 'b')
            plotmastuoutline;
            plot(config)        
        end 
        che = che + 1;
    end
end
print('6M', '-dpng');
clf

che = 0;  % initializes determinator of config and mastoutline plot
for displ=-40:40
    for control_p=7
        %calculate the change in the location of the control points
        [icoil_total]=v_circ_explorer(equil, coilset, smatrix, displ, control_p);

        % Introduce feedback & calculate first new equilibrium
        feedback=fiesta_feedback2(get(config,'grid'), coilset, 'p6', iso);
        equil_new=set(equil,config,'feedback',feedback,'control',control);
        equil_new=set(equil_new,config,'icoil',icoil_total);
        [x_control_vc, y_control_vc, conn_len_vc]=control_pointsV30(equil_new);

        delta_x=x_control-x_control_vc;
        delta_y=abs(y_control)-abs(y_control_vc); %kludge for when the xpts are other way up
        delta_vc(control_p,:)=sqrt(delta_x.^2+delta_y.^2);

        vals=fopen('7M.txt', 'a');
        fprintf(vals, '%f', icoil_total.d5);
        for j=1:numel(x_control)
            if j < numel(x_control)
                fprintf(vals, ' %f', delta_vc(control_p,j));
            end
            if j == numel(x_control)
             fprintf(vals, ' %f\n', delta_vc(control_p,j));
            end
        end
        fclose(vals);
        
        plot(equil_new, 'psi_boundary', 'r') 
        if che==0
            hold on
            plot(equil_orig, 'psi_boundary', 'b')
            plotmastuoutline;
            plot(config)        
        end 
        che = che + 1;
    end
end
print('7M', '-dpng');
clf

che = 0;  % initializes determinator of config and mastoutline plot
for displ=-40:40
    for control_p=8
        %calculate the change in the location of the control points
        [icoil_total]=v_circ_explorer(equil, coilset, smatrix, displ, control_p);

        % Introduce feedback & calculate first new equilibrium
        feedback=fiesta_feedback2(get(config,'grid'), coilset, 'p6', iso);
        equil_new=set(equil,config,'feedback',feedback,'control',control);
        equil_new=set(equil_new,config,'icoil',icoil_total);
        [x_control_vc, y_control_vc, conn_len_vc]=control_pointsV30(equil_new);

        delta_x=x_control-x_control_vc;
        delta_y=abs(y_control)-abs(y_control_vc); %kludge for when the xpts are other way up
        delta_vc(control_p,:)=sqrt(delta_x.^2+delta_y.^2);

        vals=fopen('8M.txt', 'a');
        fprintf(vals, '%f', icoil_total.d6);
        for j=1:numel(x_control)
            if j < numel(x_control)
                fprintf(vals, ' %f', delta_vc(control_p,j));
            end
            if j == numel(x_control)
             fprintf(vals, ' %f\n', delta_vc(control_p,j));
            end
        end
        fclose(vals);
        
        plot(equil_new, 'psi_boundary', 'r') 
        if che==0
            hold on
            plot(equil_orig, 'psi_boundary', 'b')
            plotmastuoutline;
            plot(config)        
        end 
        che = che + 1;
    end
end
print('8M', '-dpng');
clf

che = 0;  % initializes determinator of config and mastoutline plot
for displ=-40:40
    for control_p=9
        %calculate the change in the location of the control points
        [icoil_total]=v_circ_explorer(equil, coilset, smatrix, displ, control_p);

        % Introduce feedback & calculate first new equilibrium
        feedback=fiesta_feedback2(get(config,'grid'), coilset, 'p6', iso);
        equil_new=set(equil,config,'feedback',feedback,'control',control);
        equil_new=set(equil_new,config,'icoil',icoil_total);
        [x_control_vc, y_control_vc, conn_len_vc]=control_pointsV30(equil_new);

        delta_x=x_control-x_control_vc;
        delta_y=abs(y_control)-abs(y_control_vc); %kludge for when the xpts are other way up
        delta_vc(control_p,:)=sqrt(delta_x.^2+delta_y.^2);

        vals=fopen('9M.txt', 'a');
        fprintf(vals, '%f', icoil_total.d7);
        for j=1:numel(x_control)
            if j < numel(x_control)
                fprintf(vals, ' %f', delta_vc(control_p,j));
            end
            if j == numel(x_control)
             fprintf(vals, ' %f\n', delta_vc(control_p,j));
            end
        end
        fclose(vals);
        
        plot(equil_new, 'psi_boundary', 'r') 
        if che==0
            hold on
            plot(equil_orig, 'psi_boundary', 'b')
            plotmastuoutline;
            plot(config)        
        end 
        che = che + 1;
    end
end
print('9M', '-dpng');
clf

che = 0;  % initializes determinator of config and mastoutline plot
for displ=-40:40
    for control_p=10
        %calculate the change in the location of the control points
        [icoil_total]=v_circ_explorer(equil, coilset, smatrix, displ, control_p);

        % Introduce feedback & calculate first new equilibrium
        feedback=fiesta_feedback2(get(config,'grid'), coilset, 'p6', iso);
        equil_new=set(equil,config,'feedback',feedback,'control',control);
        equil_new=set(equil_new,config,'icoil',icoil_total);
        [x_control_vc, y_control_vc, conn_len_vc]=control_pointsV30(equil_new);

        delta_x=x_control-x_control_vc;
        delta_y=abs(y_control)-abs(y_control_vc); %kludge for when the xpts are other way up
        delta_vc(control_p,:)=sqrt(delta_x.^2+delta_y.^2);

        vals=fopen('10M.txt', 'a');
        fprintf(vals, '%f', icoil_total.dp);
        for j=1:numel(x_control)
            if j < numel(x_control)
                fprintf(vals, ' %f', delta_vc(control_p,j));
            end
            if j == numel(x_control)
             fprintf(vals, ' %f\n', delta_vc(control_p,j));
            end
        end
        fclose(vals);
        
        plot(equil_new, 'psi_boundary', 'r') 
        if che==0
            hold on
            plot(equil_orig, 'psi_boundary', 'b')
            plotmastuoutline;
            plot(config)        
        end 
        che = che + 1;
    end
end
print('10M', '-dpng');
clf

che = 0;  % initializes determinator of config and mastoutline plot
for displ=-40:40
    for control_p=11
        %calculate the change in the location of the control points
        [icoil_total]=v_circ_explorer(equil, coilset, smatrix, displ, control_p);

        % Introduce feedback & calculate first new equilibrium
        feedback=fiesta_feedback2(get(config,'grid'), coilset, 'p6', iso);
        equil_new=set(equil,config,'feedback',feedback,'control',control);
        equil_new=set(equil_new,config,'icoil',icoil_total);
        [x_control_vc, y_control_vc, conn_len_vc]=control_pointsV30(equil_new);

        delta_x=x_control-x_control_vc;
        delta_y=abs(y_control)-abs(y_control_vc); %kludge for when the xpts are other way up
        delta_vc(control_p,:)=sqrt(delta_x.^2+delta_y.^2);

        vals=fopen('11M.txt', 'a');
        fprintf(vals, '%f', icoil_total.pc);
        for j=1:numel(x_control)
            if j < numel(x_control)
                fprintf(vals, ' %f', delta_vc(control_p,j));
            end
            if j == numel(x_control)
             fprintf(vals, ' %f\n', delta_vc(control_p,j));
            end
        end
        fclose(vals);
        
        plot(equil_new, 'psi_boundary', 'r') 
        if che==0
            hold on
            plot(equil_orig, 'psi_boundary', 'b')
            plotmastuoutline;
            plot(config)        
        end 
        che = che + 1;
    end
end
print('11M', '-dpng');
clf