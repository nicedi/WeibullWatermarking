function out = compMdl( data )
% data is klDat or mseDat
    addpath('./zigzag');
    a = mean(data, 5); % 10-fold average
    a = mean(a, 4); % average over all images
    out = zeros(4, 64);
    for i = 1:4
        tsqu = squeeze(a(i,:,:));
        out(i,:) = zigzag(tsqu);
    end
    out(:,1) = [];% remove DC component      

end

