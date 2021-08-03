% Function handle to evaluate the image in blocks of 7 rows and 11 columns
% multiplied element wise by the ones matrix using the same dimensions such
% that the output matrix will be the same size as the input matrix. 
fun = @(block_struct) mean2(block_struct.data).*ones(7,11);

% newV is the output matrix of the block analysis outputting the average of
% the block in every element of the block such maintaining the same
% dimensions as the input matrix
blockV = blockproc(V,[7 11],fun);
