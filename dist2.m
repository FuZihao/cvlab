function [ cost ] = dist2(his1, his2)

tmp = (his1-his2).^2 ./ (his1+his2);
tmp(isnan(tmp))=0;
cost = 1/2 * sum( tmp );

end
