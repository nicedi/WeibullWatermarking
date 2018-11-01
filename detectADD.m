ATTDCTblks1 = compDCTblks(imgATT1, imgnum);

coef1 = reshape(ATTDCTblks1(WMblks ~= 0), [wmlength imgnum]);
coef0 = reshape(ATTDCTblks0(WMblks ~= 0), [wmlength imgnum]);

% nonlinear coefficients
coef1nl = ZMNL(coef1);
coef0nl = ZMNL(coef0);

maskATT1 = DCTmask(ATTDCTblks1);
m0 = reshape(maskATT0(WMblks ~= 0), [1024 20]);
m1 = reshape(maskATT1(WMblks ~= 0), [1024 20]);

% maskWBL1 = compWblMask(ATTDCTblks1, maskATT1);
% m0Wbl = reshape(maskWBL0(WMblks ~= 0), [1024 20]);
% m1Wbl = reshape(maskWBL1(WMblks ~= 0), [1024 20]);

if strcmp(attackCategory, 'jpeg')
    params1 = getParamsLSE(ATTDCTblks1, co);
else
    params1 = getParams(ATTDCTblks1, co);
end

for p = 1:imgnum
    alpha1 = params1(1, p, 1, 1);
    beta1 = params1(1, p, 1, 2);
    
    alpha0 = params0(k, p, 1, 1);
    beta0 = params0(k, p, 1, 2);
    
    result(j,k,p,1,1) = detector_ggd_ump_ADD(alpha1, beta1, coef1(:,p), wm, m1(:,p)); 
    result(j,k,p,1,2) = detector_ggd_ump_ADD(alpha0, beta0, coef0(:,p), wm, m0(:,p));
    
    result(j,k,p,2,1) = detector_ggd_lod_ADD(alpha1, beta1, coef1(:,p), wm);
    result(j,k,p,2,2) = detector_ggd_lod_ADD(alpha0, beta0, coef0(:,p), wm);
    
% ----------------------------------------------------------------------------------
    
    delta1 = params1(1, p, 2, 1);
    gamma1 = params1(1, p, 2, 2);
    
    delta0 = params0(k, p, 2, 1);
    gamma0 = params0(k, p, 2, 2);
    
    result(j,k,p,3,1) = detector_cauchy_ump_ADD(delta1, gamma1, coef1(:,p), wm, m1(:,p)); 
    result(j,k,p,3,2) = detector_cauchy_ump_ADD(delta0, gamma0, coef0(:,p), wm, m0(:,p)); 
    
%     result(j,k,p,4,1) = detector_cauchy_ump_ADD(delta1, gamma1, coef1nl(:,p), wm, m1(:,p));
%     result(j,k,p,4,2) = detector_cauchy_ump_ADD(delta0, gamma0, coef0nl(:,p), wm, m0(:,p));
    result(j,k,p,4,1) = coef1nl(:,p)' * (wm .* m1(:,p));
    result(j,k,p,4,2) = coef0nl(:,p)' * (wm .* m0(:,p));
    
    result(j,k,p,5,1) = detector_cauchy_lod_ADD(delta1, gamma1, coef1(:,p), wm); 
    result(j,k,p,5,2) = detector_cauchy_lod_ADD(delta0, gamma0, coef0(:,p), wm); 
    
    
% ----------------------------------------------------------------------------------
    
    lambda1 = params1(1, p, 3, 1);
    nu1 = params1(1, p, 3, 2);
    
    lambda0 = params0(k, p, 3, 1);
    nu0 = params0(k, p, 3, 2);
        
    result(j,k,p,6,1) = detector_stu_ump_ADD(lambda1, nu1, coef1(:,p), wm, m1(:,p));
    result(j,k,p,6,2) = detector_stu_ump_ADD(lambda0, nu0, coef0(:,p), wm, m0(:,p));
    
    result(j,k,p,7,1) = detector_stu_lod_ADD(lambda1, nu1, coef1(:,p), wm);
    result(j,k,p,7,2) = detector_stu_lod_ADD(lambda0, nu0, coef0(:,p), wm);
    
    
% ----------------------------------------------------------------------------------        
    
%     a1 = params1(1, p, 4, 1);
%     ro1 = params1(1, p, 4, 2);
%     
%     a0 = params0(k, p, 4, 1);
%     ro0 = params0(k, p, 4, 2);
%     
%     result(j,k,p,8,1) = detector_wbl_ump(a1, ro1, abs(coef1(:,p)), wm, m1Wbl(:,p));    
%     result(j,k,p,8,2) = detector_wbl_ump(a0, ro0, abs(coef0(:,p)), wm, m0Wbl(:,p));
%     
%     result(j,k,p,9,1) = detector_wbl_lod(a1, ro1, abs(coef1(:,p)), wm);    
%     result(j,k,p,9,2) = detector_wbl_lod(a0, ro0, abs(coef0(:,p)), wm);

    
end
