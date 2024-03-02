function [ output ] = OrientationCal( input )
%ORIENTATIONCAL Summary of this function goes here
%   Detailed explanation goes here
    %output = mod(abs(input), 4);
    %output = min(max(input,0),3);
    output = floor(mod(input,4));

end

