function [y] = intdump(data, nsamp)
//Integrates the symbol over its length and outputs the averages.
//If the input is a matrix, then each column is treated as a separate channel

//input:
//data - input channel data
//nsamp - number of samples per symbol

//Example: 
//a= [1 2 3 4 5 6]'; 
//a=[a a+1]; 
//intdump(a, 3);
//written by Srikanth Kuthuru, FOSSEE, IIT Madras.

if(~isreal(data)) then
    error("input data must be real");
end
if(length(nsamp) ~= 1) then
    error("nsamp must be a scalar")
end
if(~isreal(nsamp) | modulo(nsamp,1) ~= 0) then
    error("Number of samples must be an integer");
end
//if input is a row, then convert it to a column
row_flag = 0; //is zero if the input is a column vector and vice-versa
[nrows_data ncols_data] = size(data);
if (nrows_data == 1) then
    data = data(:);
    row_flag = 1;
    [nrows_data ncols_data] = size(data);
end
if(modulo(nrows_data,nsamp) ~= 0) then
    error("length of input data should be an integer multiple of nsamp");
end
//end of checks

n_symbols = nrows_data/nsamp; //number of symbols in each channel
P = matrix(data, nsamp, n_symbols, ncols_data);
P = mean(P, 1); //mean of the rows (dimension-1) in the 3D matrix
out = matrix(P, n_symbols, ncols_data);
if (row_flag == 0) then
    y = out;
else
    y = out';   //if input is a row vector, then output should be row vector
end
endfunction
