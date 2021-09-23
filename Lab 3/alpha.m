function [res] = alpha(Delta)
    for i=1:size(Delta,1)
        res(i) = Delta(i,i)/sum(sum(Delta));
    end
end

