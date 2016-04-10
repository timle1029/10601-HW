function ly = changeY(y)
samples = size(y,1);
ly =  zeros(samples, 10);
for i = 1:1:samples
    ly(i,y(i,1)+1) = 1;
end
end

