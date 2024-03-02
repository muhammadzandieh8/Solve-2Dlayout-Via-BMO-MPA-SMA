function Map=MapBarnacles(Map,PinesLength,Xcenter,YCenter)    
     center = [Xcenter,YCenter];
     [X, Y] = meshgrid(1:size(Map,2), 1:size(Map,1));
     distances = sqrt((X - center(1)).^2 + (Y - center(2)).^2);
     Map(distances <= PinesLength) = 1;
end