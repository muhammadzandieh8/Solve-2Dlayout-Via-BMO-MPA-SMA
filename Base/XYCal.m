function [ output ] = XYCal( input,Range )
    output = floor(mod(abs(input),Range));
end