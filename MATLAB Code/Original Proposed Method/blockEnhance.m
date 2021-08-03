% Function handles and their complimentary block process outputs

funMin = @(block_struct) minimumValue(block_struct.data); % Function handle for minimumValue
minBlockV = blockproc(V,[7 11],funMin); % minimum value of each block

funMed = @(block_struct) medianValue(block_struct.data); % Function handle for medianValue
medBlockV = blockproc(V,[7 11],funMed); % median value of each block

funMax = @(block_struct) maximumValue(block_struct.data); % Function handle for maximumValue
maxBlockV = blockproc(V,[7 11],funMax); % maximum value of each block
