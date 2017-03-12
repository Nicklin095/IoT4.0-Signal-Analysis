function [Data_MaxMin]=DataMaxMin(InputData)

global dataMax dataMin
dataMax=max(InputData);
dataMin=min(InputData);
Data_MaxMin=[dataMax;dataMin];

end
