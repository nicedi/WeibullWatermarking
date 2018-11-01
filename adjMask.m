function M = adjMask(dctblks, mask)
%     while 1
%         idx = abs(mask .* embedpos) > abs(dctblks .* embedpos);% (2, 11, 1) == 1
%         if sum(idx(:)) == 0
%             break;
%         end
%         mask(idx) = dctblks(idx) / 2;
% %         mask(idx) = abs(dctblks(idx));
%     end
%     M = mask;

    M = mask / 5;
    M(M > abs(dctblks)) = dctblks(M > abs(dctblks));
end
