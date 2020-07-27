using Images
"""

Transformer une image en float en une image en RGB

# Entrée
* **img**       : (Array{Float64,3}) image en UInt8

# Sorties
* **image_rgb** : (Array{RGB{N0f8},2} with eltype RGB{Normed{UInt8,8}}) image en RGB
"""
function float2im(img)

    # Transformer en float et normaliser
    if maximum(img)>1
        img = float(img)./255
    end
    a = size(img)[1]
    b = size(img)[2]

    image_rgb = zeros(RGB{N0f8},a,b)
    for k=1:a
        for l=1:b
            image_rgb[k,l] = RGB(img[k,l,1],img[k,l,2],img[k,l,3])
        end
    end
    return image_rgb
end