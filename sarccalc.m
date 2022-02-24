function [SMA, MHU] = sarccalc(data_path, mask_path, level)

data = niftiread(data_path);
mask = niftiread(mask_path);
header = niftiinfo(data_path);
header_mask = niftiinfo(mask_path);

pixSize = header.PixelDimensions(1)*header.PixelDimensions(2);

SIZE = size(data);


data = data *header.raw.scl_slope + header.raw.scl_inter;

%pre-processing/thresholding to [-29,150] HU
for i = 1:SIZE(1)
    for j = 1:SIZE(2)
        for k = 1:SIZE(3)
            if mask (i,j,k) ~= 0
                if (data(i,j,k) < -29) | (data(i,j,k) > 150)
                    mask (i,j,k) = 0;
                end
            end
        end
    end
end

output_path = strcat('pp', mask_path);
niftiwrite(mask,output_path,header_mask);

%T4
%Label 2: Major, Label 3: Minor
if level == 4
    %first one major, second one minor
    SMA = zeros(2,1);
    MHU = zeros(2,1);
    
    %pixel count
    major_count = 0;
    minor_count = 0;
    
    major_HU_count = 0;
    minor_HU_count = 0;
    
    for i = 1:SIZE(1)
        for j = 1:SIZE(2)
            for k = 1:SIZE(3)
                if mask (i,j,k) == 2
                    major_count = major_count + 1;
                    major_HU_count = major_HU_count + data(i,j,k);
                elseif mask (i,j,k) == 3
                    minor_count = minor_count + 1;
                    minor_HU_count = minor_HU_count + data(i,j,k);
                end
            end
        end
    end
    
    SMA(1,1) = double(major_count) * pixSize;
    SMA(2,1) = double(minor_count) * pixSize;
    MHU (1,1) = double(major_HU_count)/major_count;
    MHU (2,1) = double(minor_HU_count)/minor_count;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %T12
 %Label 1: Musculature       
 
elseif level == 12
    SMA = zeros(1);
    MHU = zeros(1);
    
    %pixel count
    muscle_count = 0;
    muscle_HU_count = 0;
    
    for i = 1:SIZE(1)
        for j = 1:SIZE(2)
            for k = 1:SIZE(3)
                if mask (i,j,k) == 1
                    muscle_count = muscle_count + 1;
                    muscle_HU_count = muscle_HU_count + data(i,j,k);
                end
            end
        end
    end
    
    SMA = double(muscle_count) * pixSize;
    MHU = double(muscle_HU_count)/muscle_count;
end




