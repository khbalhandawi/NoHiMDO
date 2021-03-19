function [obj,y,c_ineq] = SBJ_subsystem_analysis_2(subproblem_index,x_DV,PB)

% default values
obj = 0;
y = [];
c_ineq = [];

% Constants
h = PB.UserData.altitude;
M = PB.UserData.Mach;

switch subproblem_index
    case 1
        %% Aircraft design
        % Discipline variables (DV)
        [SFC,We,LD,Ws,Wf] = get_variable(x_DV,PB,'SFC_1','We_1','LD_1','Ws_1','Wf_1');
        % Subproblem analysis
        [Wt,range] = SBJ_analysis_range(We,Wf,Ws,h,M,LD,SFC);
        % Subproblem constraints
        c_ineq = 1 - (range/2000);
        c_ineq = max(c_ineq,0)^2;
        % Coupling variables (CV) - response
        y = Wt;
        % Subproblem objective
        obj = Wt;
    case 2 
        %% Propulsion design
        % Discipline variables (DV)
        [D,T] = get_variable(x_DV,PB,'D_2','T');  
        % Subproblem analysis
        [SFC,We,ESF,Temp_E,Throttle_uA] =  SBJ_analysis_power(h,M,T,D);
        % Subproblem constraints
        Dim_Throttle = T*16168;   %--non-diminsional throttle setting
        Temp_uA=1.02;
        c_ineq(1) = Temp_E/Temp_uA-1; %--engine temperature constraint
        c_ineq(2) = Dim_Throttle/Throttle_uA-1;  %--throttle constraint
        % Coupling variables (CV) - response
        y = [We,SFC,ESF];
        % Subproblem objective
        obj = 0;
    case 3
        %% Aerodynamics design
        % Discipline variables (DV)
        [ESF,Wt,theta,tc,ARw,LAMBDAw,Sref,Sht,ARht,LAMBDAht,Lw,Lht] = split_vector(x_DV);
        % Subproblem analysis
        Z = [tc,h,M,ARw,LAMBDAw,Sref,Sht,ARht];
        [L,D,LD,Pg,CLo1,CLo2] =  SBJ_analysis_dragpolar(Z,LAMBDAht,Lw,Lht,Wt,theta,ESF,tc);
        % Subproblem constraints
        Pg_uA=1.1;
        c_ineq(1)=Pg/Pg_uA-1;  %--adverse pressure gradient constraint
        c_ineq(2) = CLo1;  %--lift coefficient constraint 1
        c_ineq(3) = CLo2;  %--lift coefficient constraint 2
        % Coupling variables (CV) - response
        y = [D,LD,L];
        % Subproblem objective
        obj = 0;
    case 4
        %% Structural design
        % Discipline variables (DV)
        [L,tc,ARw,LAMBDAw,Sref,Sht,ARht,lambda] = get_variable(x_DV,PB,'L_4','tc_4','ARw_4','LAMBDAw_4','Sref_4','Sht_4','ARht_4','lambda_4');  
        [t,ts] = get_variable(x_DV,PB,'t','ts');  
        % Subproblem analysis
        Z = [tc,h,M,ARw,LAMBDAw,Sref,Sht,ARht];
        [Ws , Wf, theta, G1] = SBJ_analysis_structural(Z,t,ts,lambda,L);
        % Subproblem constraints
        c_ineq = G1; %--structural constraints (59 components)
        % Coupling variables (CV) - response
        y = [Ws,Wf,theta];
        % Subproblem objective
        obj = 0;
    otherwise
        error('unrecognized subproblem index')
end