function [p] = prior(yTrain)
    [z,1]=size(yTrain);
    p = zeros(10,1);
    for i = 1:z;
        switch yTrain(i)
            case 1
                p(1) = p(1) + 1;
            case 2
                p(2) = p(2) + 1;
            case 3
                p(3) = p(3) + 1;
            case 4
                p(4) = p(4) + 1;
            case 5
                p(5) = p(5) + 1;
            case 6
                p(6) = p(6) + 1;
            case 7
                p(7) = p(7) + 1;
            case 8
                p(8) = p(8) + 1;
            case 9
                p(9) = p(9) + 1;
            case 0
                p(10) = p(10) + 1;
        end
    end
    for i =1:10
        p(i,1) = p(i,1)/z;
    end
end
