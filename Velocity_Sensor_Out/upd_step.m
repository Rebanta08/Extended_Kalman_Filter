function [uCurr,covar_curr] = upd_step(z_t,covarEst,uEst)
%% BEFORE RUNNING THE CODE CHANGE NAME TO upd_step
    %% Parameter Definition
    %z_t - is the sensor data at the time step
    %covarEst - estimated covar of the  state
    %uEst - estimated mean of the state
%% To derive the Jacobian C_t:
%V=sym('V',[3,1]);                                                                         
%X=sym('X',[15,1]);
%process=@(V,X)[X(7:9)+V(1:3)];
%Ct=matlabFunction(simplify(jacobian(process(V,X),X)),'Vars',{V;X});
%% Obtaining covar_curr and uCurr:
    C_t=[0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0;
         0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0;
         0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0];    
    Z_t=C_t*uEst;
    R=ones(3)*0.00001;
    K_t=covarEst*(C_t')/(C_t*covarEst*(C_t')+R);
    covar_curr=covarEst-K_t*C_t*covarEst;
    uCurr=uEst+K_t*(z_t-Z_t);    
end