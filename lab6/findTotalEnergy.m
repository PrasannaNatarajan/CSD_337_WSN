function a = findTotalEnergy(TotE,S,n,r)
%This sums up the total energy of the elements
%in the network
    a=0;
    for ct=1:1:n
        a = TotE(r+1) + S(ct).E;
    end
end