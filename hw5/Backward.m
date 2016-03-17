function [Beta] = Backward(a, b, p, X)
	[N, T] = size(X);
	[K, K] = size(a);
	[K, M] = size(b);
	[K, L] = size(p);
	Btemp = zeros(N*T, K);
	line = 0;
	z = ones(N,1);
	z = z.*T;
	for e = 1:T:T*N
		btemp = zeros(T, K);
		line = line + 1;
		for i = 1:1:K
			btemp(T,i) = 1;
		end
		for f = T-1:-1:1
			for g = 1:1:K
				for h = 1:1:K
					btemp(f,g) = btemp(f+1,h) * a(g,h) * b(h,X(line,f+1)) + btemp(f,g);
				end
			end
		end
		Btemp(e:e - 1 + T,:) = btemp;
	end
	Beta = mat2cell(Btemp, z);
end