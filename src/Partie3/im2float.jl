function im2float(im)

    a,b = size(im)
    
    image = zeros(a,b,3)
    for i in 1:a
        for j in 1:b
            image[i,j,:] = [float(im[i,j].r),float(im[i,j].g),float(im[i,j].b)]
        end
    end

    return image
end