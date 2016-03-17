function [a, b, p] = M_step(Gamma, Xi, X, M, K)
	[N,T]= size(X);		
	a = zeros(K,K);
	b = zeros(K,M);
	p = zeros(K,1);
	tempp = zeros(K,1);
	suma = zeros(K,1);
	sumb = zeros(K,1);
	for z = 1:1:N
		tempa = zeros(K,K);
		tempb = zeros(K,M);
		xtemp = Xi{z,1};
		gtemp = Gamma{z,1};
		[T,K,K] = size(xtemp);
		[T,K] = size(gtemp);
		for i = 1:1:K
			ntemp = zeros(K,1);
			for j = 1:1:K	
				for t = 1:1:T
					ntemp(j,1) = ntemp(j,1) + xtemp(t,i,j);
				end
			end
			for j = 1:1:K
				suma(i,1) = suma(i,1) + ntemp(j,1);
			end
			for j = 1:1:K
				tempa(i,j) = ntemp(j,1);
			end
		end
		a = tempa + a;
		for i = 1:1:K
			mtemp = zeros(M,1);
			for t = 1:1:T
				o = X(z,t);
				mtemp(o,1) = mtemp(o,1) + gtemp(t,i);
			end
			for j = 1:1:M
				sumb(i,1) = sumb(i,1) + mtemp(j,1);
			end
			for j = 1:1:M
				tempb(i,j) = mtemp(j,1);
			end
		end
		b = b + tempb;
		p = p + gtemp(1,:)';
		% tempp = tempp + gtemp(1,:)';
	end
	for i = 1:1:K
		for j = 1:1:K
			a(i,j) = a(i,j)/suma(i,1);
		end
	end
	for i = 1:1:K
		for j = 1:1:M
			b(i,j) = b(i,j)/sumb(i,1);
		end
	end
	for i = 1:1:K
		p(i,1) = p(i,1)/N;
	end
end