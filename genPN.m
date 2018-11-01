function PNmtx=genPN(len, shift)
    N=1000;
    h=commsrc.pn('GenPoly',[34 15 14 1 0],'NumBitsOut',len,'Shift',shift);
    PNmtx=zeros(len,N);
    for i=1:N
        PNmtx(:,i)=generate(h);
    end
    PNmtx=PNmtx*2-1;% -1 or 1
end