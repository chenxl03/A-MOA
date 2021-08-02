function error = error_rt8apx2a(x,x_r1)

c1_r=(sum(x_r1(1:4))>1);
c2_r=(sum(x_r1(5:8))>1);

s1 = xor( xor(x(1),x(2)), xor(x(3),x(4)) );
s2 = xor( xor(x(5),x(6)), xor(x(7),x(8)) );


%e1_f = e1 & c1_r;
%e2_f = e2 & c2_r;
%c1_f = c1_r | e1;
%c2_f = c2_r | e2;
%e3 = s1 & s2 & c1_f & c2_f;
e1_r = x_r1(1) & x_r1(2) & x_r1(3) & x_r1(4);
e2_r = x_r1(5) & x_r1(6) & x_r1(7) & x_r1(8);
ex_r = e1_r & e2_r;

e1 = x(1) & x(2) & x(3) & x(4);
e2 = x(5) & x(6) & x(7) & x(8);
s12 = e1 + e2;
ex = (s12==1);

e3 = s1 & s2 & c1_r & c2_r;

error = ex_r + ex + e3;

%e1 = x(1) & x(2) & x(3) & x(4)
%e2 = x(5) & x(6) & x(7) & x(8)
%
%s1 = xor( xor(x(1),x(2)), xor(x(3),x(4)) ) | e1
%s2 = xor( xor(x(5),x(6)), xor(x(7),x(8)) ) | e2
%
%c1_r=(sum(x_r(1:4))>=2)
%c2_r=(sum(x_r(5:8))>=2)
%
%e1_f = e1 & c1_r
%e2_f = e2 & c2_r
%
%c1_f = c1_r | e1
%c2_f = c2_r | e2
%
%e3 = s1 & s2 & c1_f & c2_f
%
%error = e1_f + e2_f + e3

end
