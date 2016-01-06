function [y] = matintrlv(data, Nrows, Ncols)
//matrix interleave
//input 
//data - should be in the form of columns. If data is a matrix then each column in the matrix is interleaved separately
//Algorithm:
//The input data is filled row-by-row in a Nrows x Ncols matrix and later read column-by-column to give the output.

//Example:
//a= [1 2 3 4 5 6]'; 
//a=[a a+1]; 
//matintrlv(a,2,3);
//written by Srikanth Kuthuru, FOSSEE, IIT Madras.



if(~isreal(data)) then
    error("input data must be real");
end
if(length(Nrows) ~= 1 | length(Ncols) ~= 1) then
    error("Nrows, Ncols must be scalars");
end
if(~isreal(Nrows) | ~isreal(Ncols) | modulo(Nrows,1) ~= 0 | modulo(Ncols,1) ~= 0) then
    error("Number of rows, columns must be integers");
end
//if input is a row, then convert it to a column
row_flag = 0; //is zero if the input is a column vector and vice-versa
[nrows_data ncols_data] = size(data);
if (nrows_data == 1) then
    data = data(:);
    [nrows_data ncols_data] = size(data);
    row_flag = 1;
end

if(modulo(nrows_data , (Nrows*Ncols)) ~= 0) then
    error("Incompatible dimensions");
end
//End of checks

P = matrix(data, Ncols, Nrows, ncols_data);  
P = permute(P, [2,1,3]); //Filling row-by-row
out = matrix(P, nrows_data, ncols_data); //read column-by-column
if (row_flag == 0) then
    y = out;
else
    y = out';   //if input is a row vector, then output should be row vector
end
 
endfunction
