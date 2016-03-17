function [a,b,p] = EM_estimate(a, b, p, X, nIter)
	[K,M]= size(b);
	for i = 1:1:nIter
		A = Forward(a, b, p, X);
		B = Backward(a, b, p, X);
		[Gamma, Xi] = E_step(a, b, p, X);
		[a, b, p] = M_step(Gamma, Xi, X, M, K);
	end