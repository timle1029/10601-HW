function [t, mu, sigma] = EM(X, k, t0, mu0, sigma0, nIter)
%[n,f]=size(X);
%[k,f]=size(mu0);
for i = 1:nIter
    w0=Expectation(X,k,t0,mu0,sigma0);
    mu0=MaximizeMean(X,k,w0);
    sigma0=MaximizeCovariance(X,k,w0,mu0);
    t0=MaximizeMixtures(k,w0);
end
t = t0;
mu = mu0;
sigma = sigma0;
end