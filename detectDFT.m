coef1 = zeros(size(imgATT1));
for i = 1:imgnum
    coef1(:,:,i) = abs(fftshift(step(fftobj, squeeze(imgATT1(:,:,i)))));
end

for p = 1:imgnum
    c1_temp = coef1(:,:,p);
    c1 = c1_temp(mask);
    
    c0_temp = coef0(:,:,p);
    c0 = c0_temp(mask);
    
    [a1, ro1] = mle_wbl(c1);
    [a0, ro0] = mle_wbl(c0);
    
%     result(j,p,1,1) = detector_wbl_ump(a1, ro1, abs(coef1(:,p)), wm, wmstrength); 
%     result(j,p,1,2) = detector_wbl_ump(a0, ro0, abs(coef0(:,p)), wm, wmstrength);  
    
    result(j,p,1,1) = detector_wbl_lod(a1, ro1, c1, wm);    
    result(j,p,1,2) = detector_wbl_lod(a0, ro0, c0, wm);
    
    result(j,p,2,1) = detector_wbl_ump(a1, ro1, c1, wm, wmstrength);    
    result(j,p,2,2) = detector_wbl_ump(a0, ro0, c0, wm, wmstrength);
    
   
end
