function [Gamma, Xi] = E_step(a, b, p, X)
	[N, T] = size(X);
	[K, K] = size(a);
	[K, M] = size(b);
	[K, L] = size(p);
	line = 0;
	Gtemp = zeros(N*T,K);
	gtemp = zeros(T,K);
	atemp = zeros(T,K);
	btemp = zeros(T,K);
	Xtemp = zeros(N*T,K,K);
	xtemp = zeros(T,K,K);
	z = ones(N,1);
	z = z.*T;
	for q = 1:1:N
		Alpha = Forward(a, b, p, X);
		Beta = Backward(a, b, p, X);
		atemp = Alpha{q,1};
		btemp = Beta{q,1};
		for t = 1:1:T
			sum = 0;
			for j = 1:1:K
				sum = sum + atemp(t,j)*btemp(t,j);
			end
			for j = 1:1:K
				gtemp(t,j) = atemp(t,j)*btemp(t,j)/sum;
			end
		end
		Gtemp((q-1)*T+1:q*T,:) = gtemp;
		for i = 1:1:K
			for j = 1:1:K
				xtemp(1,i,j) = 0;
			end
		end
		for t = 2:1:T
			sum = 0;
			for j = 1:1:K
				sum = sum + atemp(t-1,j)*btemp(t-1,j);
			end
			for j = 1:1:K
				for i = 1:1:K
					xtemp(t,i,j) = a(i,j)*b(j,X(q,t))*atemp(t-1,i)*btemp(t,j)/sum;
				end
			end
		end
		Xtemp((q-1)*T+1:q*T,:,:) = xtemp;
	end
	Gamma = mat2cell(Gtemp,z);
	Xi = mat2cell(Xtemp,z);
end