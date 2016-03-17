function [Alpha] = Forward(a, b, p, X)
	[N, T] = size(X);
	[K, K] = size(a);
	[K, M] = size(b);
	[K, L] = size(p);
	Atemp = zeros(N*T, K);
	line = 0;
	z = ones(N,1);
	z = z.*T;
	for e = 1:T:T*N
		atemp = zeros(T, K);
		line = line + 1;
		for i = 1:1:K
			atemp(1,i) = p(i,1)*b(i,X(line,1));
		end
		for f = 2:1:T
			for g = 1:1:K
				for h = 1:1:K
					atemp(f,g) = atemp(f-1,h)*a(h,g)*b(g,X(line,f))+atemp(f,g);
				end
			end
		end
		Atemp(e:e - 1 + T,:) = atemp;
	end
    Alpha = mat2cell(Atemp, z);
end