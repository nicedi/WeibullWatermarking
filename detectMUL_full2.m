ATTDCTblks1 = compDCTblks(imgATT1, imgnum);

coef1_dc = reshape(ATTDCTblks1(WMblks_dc ~= 0), [wmlength/2 imgnum]);
coef0_dc = reshape(ATTDCTblks0(WMblks_dc ~= 0), [wmlength/2 imgnum]);

coef1_ac = reshape(ATTDCTblks1(WMblks_ac ~= 0), [wmlength/2 imgnum]);
coef0_ac = reshape(ATTDCTblks0(WMblks_ac ~= 0), [wmlength/2 imgnum]);

maskDC_att = compMaskDC(imgATT1);
WM_att_dc = ATTDCTblks1 .* maskDC_att .* WMblks_dc;
WM_signal_dc = reshape(WM_att_dc(WMblks_dc ~= 0), [wmlength/2 imgnum]);

WM_att_ac = wmstrength * ATTDCTblks1 .* WMblks_ac;
WM_signal_ac = reshape(WM_att_ac(WMblks_ac ~= 0), [wmlength/2 imgnum]);

coef1 = [coef1_dc; coef1_ac];
coef0 = [coef0_dc; coef0_ac];
WM_signal = [WM_signal_dc; WM_signal_ac];

% if strcmp(attackCategory, 'jpeg') 
%     params1 = getParamsLSE(ATTDCTblks1, co);
% else
%     params1 = getParams(ATTDCTblks1, co);
% end

params1 = getParams_full2(ATTDCTblks1, lktbl);

for p = 1:imgnum
    
%     alpha1 = params1(1, p, 1, 1);
%     beta1 = params1(1, p, 1, 2);
% 
%     alpha0 = params0(k, p, 1, 1);
%     beta0 = params0(k, p, 1, 2);
%     
%     result(j,k,p,1,1) = detector_ggd_ump(alpha1, beta1, coef1(:,p), wm, wmstrength); % detection statistic (with watermark)
%     result(j,k,p,1,2) = detector_ggd_ump(alpha0, beta0, coef0(:,p), wm, wmstrength); % without watermark
%     
%     result(j,k,p,2,1) = detector_ggd_lod(alpha1, beta1, coef1(:,p), wm);
%     result(j,k,p,2,2) = detector_ggd_lod(alpha0, beta0, coef0(:,p), wm);
%     
% % ----------------------------------------------------------------------------------
%     
%     delta1 = params1(1, p, 2, 1);
%     gamma1 = params1(1, p, 2, 2);
%     
%     delta0 = params0(k, p, 2, 1);
%     gamma0 = params0(k, p, 2, 2);
%     
%     result(j,k,p,3,1) = detector_cauchy_ump(delta1, gamma1, coef1(:,p), wm, wmstrength); % detection statistic (with watermark)
%     result(j,k,p,3,2) = detector_cauchy_ump(delta0, gamma0, coef0(:,p), wm, wmstrength); % without watermark
% 
%     result(j,k,p,4,1) = detector_cauchy_lod(delta1, gamma1, coef1(:,p), wm);
%     result(j,k,p,4,2) = detector_cauchy_lod(delta0, gamma0, coef0(:,p), wm);
%      
%     
% % ----------------------------------------------------------------------------------
%     
%     lambda1 = params1(1, p, 3, 1);
%     nu1 = params1(1, p, 3, 2);
%     
%     lambda0 = params0(k, p, 3, 1);
%     nu0 = params0(k, p, 3, 2);
%     
%     result(j,k,p,5,1) = detector_stu_ump(lambda1, nu1, coef1(:,p), wm, wmstrength); % detection statistic (with watermark)   
%     result(j,k,p,5,2) = detector_stu_ump(lambda0, nu0, coef0(:,p), wm, wmstrength); % without watermark
%     
%     result(j,k,p,6,1) = detector_stu_lod(lambda1, nu1, coef1(:,p), wm);
%     result(j,k,p,6,2) = detector_stu_lod(lambda0, nu0, coef0(:,p), wm);

    
% ---------------------------------------------------------------------------------- 
    
    a1 = params1(p, 1);
    ro1 = params1(p, 2);
    
    a0 = params0(p, 1);
    ro0 = params0(p, 2);
     
    
%     result(j,1,p,1,1) = detector_wbl_lod(a1_dc, ro1_dc, abs(coef1_dc(:,p)), wm);    
%     result(j,1,p,1,2) = detector_wbl_lod(a0_dc, ro0_dc, abs(coef0_dc(:,p)), wm);

    result(j,p,1,1) = detector_wbl_lod_dc2(a1, ro1, abs(coef1(:,p)), WM_signal(:,p));    
    result(j,p,1,2) = detector_wbl_lod_dc2(a0, ro0, abs(coef0(:,p)), WM_signal(:,p));
    
    
%     result(j,p,2,1) = detector_wbl_ump(a1, ro1, abs(coef1(:,p)), wm, wmstrength); 
%     result(j,p,2,2) = detector_wbl_ump(a0, ro0, abs(coef0(:,p)), wm, wmstrength);  
    
    result(j,p,2,1) = detector_wbl_lod(a1, ro1, abs(coef1(:,p)), wm);    
    result(j,p,2,2) = detector_wbl_lod(a0, ro0, abs(coef0(:,p)), wm);

    
end
