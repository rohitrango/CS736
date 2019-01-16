function X = getStartingLabel( image, mask )
    minimum = min(image(:));
    image = image - minimum;
    maximum = max(image(:));
    
    X = zeros(size(image, 1), size(image, 2));
    
    positions = and(image <= maximum, mask == 1);
    X(positions) = 3;
    
    positions = and(image <= 2 * maximum / 3, mask == 1);
    X(positions) = 2;
    
    positions = and(image <= maximum / 3, mask == 1);
    X(positions) = 1; 
end

