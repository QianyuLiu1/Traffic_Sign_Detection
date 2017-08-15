function RPXY = RPCal(recall, precision, ratioInterpolationStep, edgecolor)
% Function: calculate RP based on recall precision curve
% Date: 20160516
% Author: Qianyu Liu


% Example
% load recall_all.mat
% load precision_all.mat
% ratioInterpolationStep = 9.99999 ;
% RPXY = RPCal(recall, precision, ratioInterpolationStep)
x = [0 recall] ;
y = [1 precision] ;

[VX, IX] = sort(x) ;
xSorted = VX ;
ySorted = y(IX) ;
xMin = min(x) ;
xMax = max(x) ;
valueInterpolationStep = (xMax - xMin) / (size(recall,2) *ratioInterpolationStep) ;

xInterpolationStep = xMin : valueInterpolationStep : xMax ;
while(1)
    flag = 0 ;
    for i = 1:1:size(xSorted,2)-1
        if xSorted(1,i) ==xSorted(1,i+1)
            xSorted(1,i) = xSorted(1,i) + 1e-4 ;
            flag = 1 ;
        end
        
        if ySorted(1,i) ==ySorted(1,i+1)
            ySorted(1,i) = ySorted(1,i) + 1e-8 ;
            flag = 1 ;
        end
    end
    if flag == 0
        break ;
    end
end
yInterpolationStep = interp1(xSorted,ySorted,xInterpolationStep) ;
RPXY=trapz(yInterpolationStep) * valueInterpolationStep ;
end

