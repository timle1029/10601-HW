function [x] = generate(a, b, p, T)
	[K,M] = size(b);
	otemp = zeros(1,T);
	qtemp = zeros(T,1);
	A = zeros(1,100);
	x = rand(1,100);
	sum = 0;
	for z = 1:1:K
		A(find(x>=sum)) = z;
		sum = sum + p(z,1);
	end
	index = fix(rand(1)*100)+1;
	qtemp(1,1) = A(1,index);
	for z = 2:1:T
		A = zeros(1,100);
		x = rand(1,100);
		sum = 0;
		for y = 1:1:K
			A(find(x>=sum)) = y;
			sum = sum + a(qtemp(z-1,1),y);
		end
		index = fix(rand(1)*100)+1;
		qtemp(z,1) = A(1,index);
	end
	for z = 1:1:T
		A = zeros(1,100);
		x = rand(1,100);
		sum = 0;
		for y = 1:1:M
			A(find(x>=sum)) = y;
			sum = sum + b(qtemp(z,1), y);
		end
		index = fix(rand(1)*100)+1;
		otemp(1,z) = A(1,index);
	end
	x = otemp;
end