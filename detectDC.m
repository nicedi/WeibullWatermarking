ATTDCTblks1 = compDCTblks(imgATT1, imgnum);

coef1 = reshape(ATTDCTblks1(WMblks ~= 0), [wmlength imgnum]);
coef0 = reshape(ATTDCTblks0(WMblks ~= 0), [wmlength imgnum]);

% maskDC_att = compMaskDC(imgATT1);
% WM_att = ATTDCTblks1 .* maskDC_att .* WMblks;
% WM_signal = reshape(WM_att(WMblks_att ~= 0), [wmlength imgnum]);

WM_att1 = wmstrength * ATTDCTblks1 .* WMblks;
WM_signal1 = reshape(WM_att1(WMblks ~= 0), [wmlength imgnum]);

WM_att0 = wmstrength * ATTDCTblks0 .* WMblks;
WM_signal0 = reshape(WM_att0(WMblks ~= 0), [wmlength imgnum]);


params1 = getParamsDC(ATTDCTblks1, co);

for p = 1:imgnum       
    
    a1 = params1(p,1);
    ro1 = params1(p,2);
    
    a0 = params0(p,1);
    ro0 = params0(p,2);
    
    result(j,p,1,1) = detector_wbl_ump(a1, ro1, abs(coef1(:,p)), wm, wmstrength); 
    result(j,p,1,2) = detector_wbl_ump(a0, ro0, abs(coef0(:,p)), wm, wmstrength);  
    
    result(j,p,2,1) = detector_wbl_lod(a1, ro1, abs(coef1(:,p)), wm);    
    result(j,p,2,2) = detector_wbl_lod(a0, ro0, abs(coef0(:,p)), wm);
    
    
    result(j,p,3,1) = detector_wbl_lod_dc2(a1, ro1, abs(coef1(:,p)), WM_signal1(:,p));    
    result(j,p,3,2) = detector_wbl_lod_dc2(a0, ro0, abs(coef0(:,p)), WM_signal0(:,p));

    
   
end
