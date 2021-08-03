% Results page working

VnewEq = histeq(Vnew,256);
standardDeviationV = std2(V);
standardDeviationVeq = std2(Veq);
standardDeviationVnew = std2(Vnew);
standardDeviationVnewEq = std2(VnewEq);


%figure(1),imhist(V),title('V Channel'),ylim('auto')
%figure(2),imhist(Veq),title('Veq Channel'),ylim('auto')

