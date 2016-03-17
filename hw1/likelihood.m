function [M, V] = likelihood(xTrain, yTrain)
a=zeros(5,5);
b=zeros(5,1);
c=zeros(5,5);
for i = 1:size(yTrain);
    switch yTrain(i);
        case 1
            a(1,:)= a(1,:)+xTrain(i,:);
            b(1)=b(1)+1;
        case 2
            a(2,:)= a(2,:)+xTrain(i,:);
            b(2)= b(2) + 1;
        case 3
            a(3,:)= a(3,:)+xTrain(i,:);
            b(3)= b(3) + 1;
        case 4
            a(4,:)= a(4,:)+xTrain(i,:);
            b(4)= b(4) + 1;
        case 5
            a(5,:)= a(5,:)+xTrain(i,:);
            b(5)= b(5) + 1;
    end
end

a(1,:) = a(1,:)/b(1);
a(2,:) = a(2,:)/b(2);
a(3,:) = a(3,:)/b(3);
a(4,:) = a(4,:)/b(4);
a(5,:) = a(5,:)/b(5);
for i = 1:size(yTrain);
    switch yTrain(i);
        case 1
            c(1,:)=c(1,:)+(xTrain(i,:)-a(1,:)).^2;
        case 2
            c(2,:)=c(2,:)+(xTrain(i,:)-a(2,:)).^2;
        case 3
            c(3,:)=c(3,:)+(xTrain(i,:)-a(3,:)).^2;
        case 4
            c(4,:)=c(4,:)+(xTrain(i,:)-a(4,:)).^2;
        case 5
            c(5,:)=c(5,:)+(xTrain(i,:)-a(5,:)).^2;
    end
end
c(1,:) = c(1,:)/b(1);
c(2,:) = c(2,:)/b(2);
c(3,:) = c(3,:)/b(3);
c(4,:) = c(4,:)/b(4);
c(5,:) = c(5,:)/b(5);

M = a';
V = c';

end
