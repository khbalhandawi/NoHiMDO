function PB = SBJ_problem_definition_1

addpath('./SBJ');

PB.UserData.altitude = 55000;
PB.UserData.Mach     = 1.4;



%             Name         SP     CV      link   dim   lb     ub   
%% Subproblem 1
PB.var{1}  = {'SFC_1'      1    false         15   1    1      4  };
PB.var{2}  = {'We_1'       1    false         16   1  100  30000  };
PB.var{3}  = {'ESF_1_2'    1    false     [17,7]   1  0.5    1.5  }; % <----- example of an incoming coupling variable between subsystems 1 and 2 (coordinated with ESF_1_3)
PB.var{4}  = {'D_1_2'      1     true     [18,9]   1 1000  70000  };
PB.var{5}  = {'Wt_1'       1     true         20   1 5000 100000  }; % <----- example of an outgoing coupling variable from subsystem 1
PB.var{6}  = {'theta_1_3'  1     true    [21,14]   1  0.2     50  };
PB.var{7}  = {'ESF_1_3'    1     true     [17,3]   1  0.5    1.5  }; % <----- example of an incoming coupling variable between subsystems 1 and 3 (coordinated with ESF_1_2)
PB.var{8}  = {'L_1_3'      1    false    [23,11]   1 5000 100000  };
PB.var{9}  = {'D_1_3'      1    false     [24,4]   1 1000  70000  };
PB.var{10} = {'LD_1'       1    false         25   1  0.1     10  };
PB.var{11} = {'L_1_4'      1     true     [35,8]   1 5000 100000  };
PB.var{12} = {'Ws_1'       1    false         37   1 5000 100000  };
PB.var{13} = {'Wf_1'       1    false         38   1 5000 100000  };
PB.var{14} = {'theta_1_4'  1    false     [36,6]   1  0.2     50  };
%% Subproblem 2
PB.var{15} = {'SFC_2'      2     true          1   1    1      4  };
PB.var{16} = {'We_2'       2     true          2   1  100  30000  };
PB.var{17} = {'ESF_2'      2     true          3   1  0.5    1.5  };
PB.var{18} = {'D_2'        2     false         4   1 1000  70000  };
PB.var{19} = {'T'          2    false         []   1  0.1      1  }; % <----- example of a local variable to subsystems 2
%% Subproblem 3
PB.var{20} = {'Wt_3'       3    false          5   1 5000 100000  };
PB.var{21} = {'theta_3'    3    false          6   1  0.2     50  };
PB.var{22} = {'ESF_3'      3    false          7   1  0.5    1.5  };
PB.var{23} = {'L_3'        3     true          8   1 5000 100000  };
PB.var{24} = {'D_3'        3     true          9   1 1000  70000  };
PB.var{25} = {'LD_3'       3     true         10   1  0.1     10  };
PB.var{26} = {'LAMBDAht'   3    false         []   1   40     70  };
PB.var{27} = {'Lw'         3    false         []   1 0.01    0.2  };
PB.var{28} = {'Lht'        3    false         []   1    1    3.5  };
PB.var{29} = {'tc_3'       3    false         42   1 0.01    0.1  };
PB.var{30} = {'ARw_3'      3    false         43   1  2.5      8  };
PB.var{31} = {'LAMBDAw_3'  3    false         44   1   40     70  }; % <----- example of a variable shared between subsystems 3 and 4
PB.var{32} = {'Sref_3'     3    false         45   1  200    800  };
PB.var{33} = {'Sht_3'      3    false         46   1   50  148.9  };
PB.var{34} = {'ARht_3'     3    false         47   1  2.5    8.5  };
%% Subproblem 4
PB.var{35} = {'L_4'        4    false         11   1 5000 100000  };
PB.var{36} = {'theta_4'    4     true         14   1  0.2     50  };
PB.var{37} = {'Ws_4'       4     true         12   1 5000 100000  };
PB.var{38} = {'Wf_4'       4     true         13   1 5000 100000  };
PB.var{39} = {'lambda_4'   4    false         []   1  0.1    0.4  };
% Vectors for structural design
PB.var{40} = {'t'          4    false         []   9  0.1    4.0 };
PB.var{41} = {'ts'         4    false         []   9  0.1    9.0 };
PB.var{42} = {'tc_4'       4    false         29   1 0.01    0.1  };
PB.var{43} = {'ARw_4'      4    false         30   1  2.5      8  };
PB.var{44} = {'LAMBDAw_4'  4    false         31   1   40     70  }; % <----- example of a variable shared between subsystems 3 and 4
PB.var{45} = {'Sref_4'     4    false         32   1  200    800  };
PB.var{46} = {'Sht_4'      4    false         33   1   50  148.9  };
PB.var{47} = {'ARht_4'     4    false         34   1  2.5    8.5  };

PB.var{48} = {'zeros'     -1     true  'ineqtol'   1  0.0    0.0  };
PB.var{49} = {'ineqtol'    2     false  'zeros'    1  0.0    10.0 };


PB.index_main = 1;
PB.analysis_file = 'SBJ_subsystem_analysis_1';
PB.end_of_iter_file = 'SBJ_display';

PB.fstar = 33600;
PB.frealistic = 30000;
