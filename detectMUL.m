ATTDCTblks1 = compDCTblks(imgATT1, imgnum);

% WM_att = ATTDCTblks1 * wmstrength .* WMblks;
% WM_signal = reshape(WM_att(WMblks ~= 0), [wmlength imgnum]);

coef1 = reshape(ATTDCTblks1(WMblks ~= 0), [wmlength imgnum]);
coef0 = reshape(ATTDCTblks0(WMblks ~= 0), [wmlength imgnum]);

% if strcmp(attackCategory, 'jpeg') 
%     params1 = getParamsLSE(ATTDCTblks1, co);
% else
%     params1 = getParams(ATTDCTblks1, co);
% end

params1 = getParams(ATTDCTblks1, co);

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
    
    a1 = params1(1, p, 4, 1);
    ro1 = params1(1, p, 4, 2);
    
    a0 = params0(k, p, 4, 1);
    ro0 = params0(k, p, 4, 2);
    
    result(j,k,p,7,1) = detector_wbl_ump(a1, ro1, abs(coef1(:,p)), wm, wmstrength); 
    result(j,k,p,7,2) = detector_wbl_ump(a0, ro0, abs(coef0(:,p)), wm, wmstrength);  
    
    result(j,k,p,8,1) = detector_wbl_lod(a1, ro1, abs(coef1(:,p)), wm);    
    result(j,k,p,8,2) = detector_wbl_lod(a0, ro0, abs(coef0(:,p)), wm);
% 
%     result(j,k,p,9,1) = detector_wbl_lod_dc2(a1, ro1, abs(coef1(:,p)), WM_signal(:,p));    
%     result(j,k,p,9,2) = detector_wbl_lod_dc2(a0, ro0, abs(coef0(:,p)), WM_signal(:,p));
    
end
