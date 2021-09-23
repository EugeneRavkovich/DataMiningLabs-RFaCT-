function [std_res] = std_per_column(X)
    for i=1:size(X,2)
        std_res(i) = std(X(:,i));
    end
end

