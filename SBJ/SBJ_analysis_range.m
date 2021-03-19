function [Wt,range] = SBJ_analysis_range(We,Wf,Ws,h,M,LD,SFC)

    Wt = We+Wf+Ws; % total weight

    %-----THIS SECTION COMPUTES THE A/C RANGE (Breguet)-----%

    if h<36089
         theta=1-0.000006875*Zh;
    else
         theta=.7519;
    end

    %-----THIS SECTION COMPUTES THE A/C RANGE-----%
    range=(M*LD*661*sqrt(theta)/SFC)*log(Wt/(Wt-Wf));


    % Range linearisation
    % tau = M*661*sqrt(theta);
    % LDref = 7.03;
    % SFCref = 1;
    % Wtref = 34300;
    % Wfref = 10300;
    % cLD = tau/SFCref*log(Wtref/(Wtref-Wfref));
    % cSFC = -tau*LDref/(SFCref^2)*log(Wtref/(Wtref-Wfref));
    % cWt = tau*LDref*SFCref*(1/Wtref - 1/(Wtref-Wfref));
    % cWf = tau*LDref*SFCref/(Wtref-Wfref);
    % R0 = (tau*LDref/SFCref)*log(Wtref/(Wtref-Wfref));
    % range = R0+cLD*LD+cSFC*SFC+cWt*Wt+cWf*Wf;

end