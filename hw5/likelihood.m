function [score] = likelihood(a, b, p, Xtest)
	[N1,T] = size(Xtest);
	[K,M] = size(b);
	stemp = zeros(N1,1);
	Alpha = Forward(a, b, p, Xtest);
	for n =1:1:N1
		atemp = Alpha{n,1};
		for i = 1:1:K
			stemp(n,1) = stemp(n,1) + atemp(T,i);
		end
		stemp(n,1) = log(stemp(n,1));
	end
	score = stemp;
end