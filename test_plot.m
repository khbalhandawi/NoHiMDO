
load 'problem_1.mat' 
load 'problem_2.mat'

subplot(2,1,1); hold on;
plot(x1_1,y1_1,'-r');
plot(x1_2,y1_2,'-b');
ylabel('max inconsistency \epsilon_q','fontsize',12);
xlabel('Outer loop iterations NO','fontsize',12);
% set(gca,'yscale','log');
hold off;
legend('hierarchical','non-hierarchical','fontsize',10)

subplot(2,1,2); hold on;

plot(x2_1,y2_1,'-r');
plot(x2_2,y2_2,'-b');
ylabel('Objective f(x)','fontsize',12);
xlabel('Outer loop iterations NO','fontsize',12);
hold off;

legend('hierarchical','non-hierarchical','fontsize',10)

set(gcf,'color','w');