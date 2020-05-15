//Endogenous variables
var 
	k (long_name = 'Physical capital intensive form (per unit of effective labor)')
	h (long_name = 'Human capital intensive form (per unit of effective labor)')
	c (long_name = 'Consumption intensive form, from disposable income (per unit of effective labor)')
	y (long_name = 'Output intensive form (per unit of effective labor)')
	saving (long_name = 'Savings (per unit of effective labor)')
    v   (long_name = 'Government transfers to households effective form');
//Exogenous variables
varexo
	t_k (long_name = 'Tax rate to physical capital')
	t_h (long_name = 'Tax rate to human capital');
//Predetermined variables
predetermined_variables
	k
	h;
//Declaring parameters
parameters
	alpha   (long_name='Output elasticity with respect to physical capital')
	eta     (long_name='Output elasticity with respect to human capital')
	s_k     (long_name='Physical capital saving rate of the economy')
	s_h     (long_name='Human capital saving rate of the economy')
	d_k     (long_name='Physical capital depreciation rate')
	d_h     (long_name='Human capital depreciation rate')
	n       (long_name='Labor growth rate')
	g       (long_name='Technology growth rate');
//Parameter values
    alpha = 0.4;
    eta = 0.2;
    d_k = 0.1;
    d_h = 0.06;
    n = 0.05;
    g = 0.02;
    s_k = 0.12;
    s_h = 0.1;
//Model equations, one per endogenous variable
model;
    [name = 'Law of motion of physical capital']
    (1+n)*(1+g) * k(+1) = s_k * (1-t_k) * y + (1-d_k) * k;
    [name = 'Law of motion of human capital']
    (1+n)*(1+g) * h(+1) = s_h * (1-t_h) * y + (1-d_h) * h;
    [name = 'Savings rule per effective labor']
    saving = (s_k + s_h) * (y + v);
    [name = 'Consume per unit of effective labor from disposable income']
    c = (1 - s_k - s_h) * (1 - t_k + t_h) * (y + v);
    [name = 'Cobb Douglas production function intensive form']
    y = (k^alpha) * (h^eta);
    [name = 'Fiscal balance']
    v = (t_k + t_h) * y;
end;
//Initial values of exogenous and endogenous variables
initval;
    t_k = 0.05;
    t_h = 0.05;
	k = 0.9 *   ((s_k*(1-t_k))/(n+g+n*g+d_k))^((1-eta)/(1-alpha-eta)) * ((s_h*(1-t_h))/(n+g+n*g+d_h))^((eta)/(1-alpha-eta));
	h = 0.9 * ((s_h*(1-t_h)*k^alpha)/(n+g+n*g+d_h))^(1/(1-eta));
	y = (k^alpha) * (h^eta);
	c = (1 - s_k - s_h) * (1 - t_k + t_h) * y;
	saving = (s_k + s_h) * y;
    v = (t_k + t_h) * y;
end;
//Steady state values or permanent shocks on exogenous variables
endval;
    t_k = 0.05;
    t_h = 0.05;
	k = ((s_k*(1-t_k))/(n+g+n*g+d_k))^((1-eta)/(1-alpha-eta)) * ((s_h*(1-t_h))/(n+g+n*g+d_h))^((eta)/(1-alpha-eta));
	h = ((s_h*(1-t_h)*k^alpha)/(n+g+n*g+d_h))^(1/(1-eta));
	y = (k^alpha) * (h^eta);
	c = (1 - s_k - s_h) * (1 - t_k + t_h) * y;
	saving = (s_k + s_h) * y;
    v = (t_k + t_h) * y;
end;
//Steady state
steady;
//Simulation for 150 periods
simul(periods=150);
//Plotting variables
rplot k, h;
rplot c, y;
