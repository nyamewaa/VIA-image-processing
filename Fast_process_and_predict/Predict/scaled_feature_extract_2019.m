folder='X:\Mercy\Image processing\VIA image processing\Processing_without_ectopion\Combined_sites\normal\';
cd 'X:\Mercy\Image processing\VIA image processing\Processing_without_ectopion\Combined_sites\normal'
dirlist = [dir('*.tif');dir('*.jpg');dir('*.png')];
[~,ndx] = natsortfiles({dirlist.name}); % indices of correct order
dirlist = dirlist(ndx);% sort structure using indices

for n=1:length(dirlist)
    cd 'X:\Mercy\Image processing\VIA image processing\Processing_without_ectopion\Combined_sites\normal'
    image = imread(dirlist(n).name);
    filename=dirlist(n).name;
    %imshow(image);
    %%
    cd 'X:\Mercy\Image processing\VIA image processing\Fast_process_and_predict\Predict'
    cervix_crop=image;
    de_spec=Remove_specular_refl(cervix_crop);
    %%
    [gab_roi,gab_rect]=gabor_segment(de_spec);
    %%
    color_feat(n,:)=color_feature_fun(gab_roi);
    texture_feat(n,:)=haralick_feature_fun(gab_rect);
    inv_feats(n,:)=[texture_feat(n,:),color_feat(n,:)];
    imwrite(gab_roi,[folder 'gabROI\' filename])
    imwrite(gab_rect,[folder 'gabRECT\' filename])
end
cd 'X:\Mercy\Image processing\VIA image processing\Processing_without_ectopion\Combined_sites\normal '
save('norm_feats.mat','norm_feats')