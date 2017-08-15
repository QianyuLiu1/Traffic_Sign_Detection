%%
% Function: calculate the IoU of two rectangles
% Date: 20160516
% Author: Qianyu Liu
% Note: GT, BBox = [ x y w h]
%           n of GT and m of BBox -> n row and m Column


function [ IoURatio ] = CalcIoU(GT, BBox)
sizeGT = size(GT,1) ;
sizeBBox = size(BBox,1) ;
areaInt = rectint(GT, BBox) ;
areaUni = zeros(sizeGT,sizeBBox) ;
% calculate the union area
for indexGT = 1:1:sizeGT
    for indexBBox = 1:1:sizeBBox
        areaUni(indexGT,indexBBox) = GT(indexGT,3) .* GT(indexGT,4) + ... 
            BBox(indexBBox,3) .* BBox(indexBBox,4) - areaInt(indexGT,indexBBox) ;
    end
end
IoURatio = areaInt ./ areaUni ;
end