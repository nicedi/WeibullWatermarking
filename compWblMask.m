function A = compWblMask(ATTDCTblks, mask)
    A = mask ./ (abs(ATTDCTblks) + eps);
%     xaw = mask .* WMblk;
%     x = ATTDCTblks - xaw;
%     A = mask ./ (x+eps);
end

