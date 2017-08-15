function [box]=Pixel2Box(regions)
n=length(regions);
box=[];
for i=1:n
    pixel=regions(i);
    pixel=pixel.PixelList;
    x_min=min(pixel(:,1));
    x_max=max(pixel(:,1));
    y_min=min(pixel(:,2));
    y_max=max(pixel(:,2));
    box_now=[x_min y_min x_max y_max]';
    box=[box box_now];
    % To initialize the location of the Bounding Box
end
end