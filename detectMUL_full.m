ATTDCTblks1 = compDCTblks(imgATT1, imgnum);

[JNDmask1, Cmask1] = DCTmask2(ATTDCTblks1);

embed_candidate1 = double(abs(ATTDCTblks1) > JNDmask1);

symbol1 = double(WMblks_ac ~= 0) .* double(ATTDCTblks1 < 0);
WM_JND1 = JNDmask1 .* embed_candidate1;
WM_JND1(logical(symbol1)) = -WM_JND1(logical(symbol1));
WM_signal1 = reshape(WM_JND1(WMblks_ac ~= 0), [wmlength imgnum]);

symbol0 = double(WMblks_ac ~= 0) .* double(ATTDCTblks0 < 0);
WM_JND0 = JNDmask0 .* embed_candidate0;
WM_JND0(logical(symbol0)) = -WM_JND0(logical(symbol0));
WM_signal0 = reshape(WM_JND0(WMblks_ac ~= 0), [wmlength imgnum]);

coef1_dc = reshape(ATTDCTblks1(WMblks_dc ~= 0), [wmlength imgnum]);
coef0_dc = reshape(ATTDCTblks0(WMblks_dc ~= 0), [wmlength imgnum]);

coef1_ac = reshape(ATTDCTblks1(WMblks_ac ~= 0), [wmlength imgnum]);
coef0_ac = reshape(ATTDCTblks0(WMblks_ac ~= 0), [wmlength imgnum]);

WM_att_dc1 = wmstrength * ATTDCTblks1 .* WMblks_dc;
WM_signal_dc1 = reshape(WM_att_dc1(WMblks_dc ~= 0), [wmlength imgnum]);

WM_att_dc0 = wmstrength * ATTDCTblks0 .* WMblks_dc;
WM_signal_dc0 = reshape(WM_att_dc0(WMblks_dc ~= 0), [wmlength imgnum]);

% maskDC_att = compMaskDC(imgATT1);
% WM_att = ATTDCTblks1 .* maskDC_att .* WMblks_dc;
% WM_signal = reshape(WM_att(WMblks_dc ~= 0), [wmlength imgnum]);

% if strcmp(attackCategory, 'jpeg') 
%     params1 = getParamsLSE(ATTDCTblks1, co);
% else
%     params1 = getParams(ATTDCTblks1, co);
% end

params1 = getParams_full(ATTDCTblks1, lktbl);

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
    
    a1_dc = params1(1, p, 1);
    ro1_dc = params1(1, p, 2);
    
    a0_dc = params0(1, p, 1);
    ro0_dc = params0(1, p, 2);
     
    
    result(j,1,p,1,1) = detector_wbl_lod(a1_dc, ro1_dc, abs(coef1_dc(:,p)), wm);    
    result(j,1,p,1,2) = detector_wbl_lod(a0_dc, ro0_dc, abs(coef0_dc(:,p)), wm);
    result(j,1,p,2,1) = detector_wbl_lod_dc2(a1_dc, ro1_dc, abs(coef1_dc(:,p)), WM_signal_dc1(:,p));    
    result(j,1,p,2,2) = detector_wbl_lod_dc2(a0_dc, ro0_dc, abs(coef0_dc(:,p)), WM_signal_dc0(:,p));
    
% ---------------------------------------------------------------------------------
    
    a1_ac = params1(2, p, 1);
    ro1_ac = params1(2, p, 2);
    
    a0_ac = params0(2, p, 1);
    ro0_ac = params0(2, p, 2);
    
%     result(j,2,p,1,1) = detector_wbl_ump(a1_ac, ro1_ac, abs(coef1_ac(:,p)), wm, wmstrength); 
%     result(j,2,p,1,2) = detector_wbl_ump(a0_ac, ro0_ac, abs(coef0_ac(:,p)), wm, wmstrength);  
%     
    result(j,2,p,1,1) = detector_wbl_lod(a1_ac, ro1_ac, abs(coef1_ac(:,p)), wm);    
    result(j,2,p,1,2) = detector_wbl_lod(a0_ac, ro0_ac, abs(coef0_ac(:,p)), wm);

    result(j,2,p,2,1) = detector_wbl_lod_jnd(a1_ac, ro1_ac, abs(coef1_ac(:,p)), WM_signal1(:,p));    
    result(j,2,p,2,2) = detector_wbl_lod_jnd(a0_ac, ro0_ac, abs(coef0_ac(:,p)), WM_signal0(:,p));

    
end
