function [ y ] = meanGeo( x )
%MEANGEO Summary of this function goes here
%   geometry mean
y=prod(x(:)) ^ (1/length(x(:)));
end

