function A = compMask(ATTDCTblks, WMblk, embedpos)
    M = DCTmask(ATTDCTblks);
%     M = abs(ATTDCTblks) * 0.2;
    M = adjMask(ATTDCTblks, M, embedpos);
    xaw = M .* WMblk;% y = x(1 + aw) <=> y = x + xaw
    x = ATTDCTblks - xaw;
    A = M ./ (x+eps);
end

