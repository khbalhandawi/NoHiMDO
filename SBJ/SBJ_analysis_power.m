function [SFC,We,ESF,Temp_E,Throttle_uA] =  SBJ_analysis_power(h,M,T,D)

    %-----THIS SECTION COMPUTES SFC, ESF, AND ENGINE WEIGHT-----% 
    C=[500.0 16000.0  4.0  4360.0  0.01375  1.0];
    Thrust = D;
    Dim_Throttle = T*16168;   %--non-diminsional throttle setting

    %-----Surface fit to engine deck (obtained using least spuares approx)-----%

    s=[1.13238425638512 1.53436586044561 -0.00003295564466 -0.00016378694115 -0.31623315541888 0.00000410691343 -0.00005248000590 -0.00000000008574 0.00000000190214 0.00000001059951];
    SFC=s(1)+s(2)*M+s(3)*h+s(4)*Dim_Throttle+s(5)*M^2+2*h*M*s(6)+2*Dim_Throttle*M*s(7)+s(8)*h^2+2*Dim_Throttle*h*s(9)+s(10)*Dim_Throttle^2; %SFC
    ESF = (Thrust/2)/Dim_Throttle; %ESF
    We = C(4)*(ESF^1.05)*2;  %We

    Dim_Throttle = T*16168;   %--non-diminsional throttle setting

    %-----THIS SECTION COMPUTES POLYNOMIAL CONSTRAINT FUNCTIONS-----%

    S_initial1=[M,h,D];
    S1=[M,h,T];
    flag1 = [2,4,2];
    bound1 = [.25,.25,.25];
    Temp_E=PolyApprox(S_initial1,S1,flag1,bound1); %--engine temperature
    

    p=[11483.7822254806 10856.2163466548 -0.5080237941 3200.157926969 -0.1466251679 0.0000068572];  
    Throttle_uA=p(1)+p(2)*M+p(3)*h+p(4)*M^2+2*p(5)*M*h+p(6)*h^2;

end