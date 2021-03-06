function test_i_limits(icoil)
% Function to check and report variations of
% 1st campaign current limits in resperctive coils.

p4 = icoil.p4 >= -18000 & icoil.p4 <= 0;
p5 = icoil.p5 >= -18000 & icoil.p5 <= 0;
px = icoil.px >= -5000 & icoil.px <= 5000;
d1 = icoil.d1 >= -5000 & icoil.d1 <= 5000;
d2 = icoil.d2 >= -5000 & icoil.d2 <= 5000;
d3 = icoil.d3 >= -5000 & icoil.d3 <= 5000;
d5 = icoil.d5 >= -5000 & icoil.d5 <= 5000;
d6 = icoil.d6 >= -4000 & icoil.d6 <= 4000;
d7 = icoil.d7 >= -5000 & icoil.d7 <= 5000;
dp = icoil.dp >= -5000 & icoil.dp <= 5000;
logic = [p4, p5, px, d1, d2, d3, d5, d6, d7, dp];
if prod(double(logic))==0
    if p4==0
        disp(sprintf('Coil p4 has a current of %d A', icoil.p4));
    end
    if p5==0
        disp(sprintf('Coil p5 has a current of %d A', icoil.p5));
    end
    if px==0
        disp(sprintf('Coil px has a current of %d A ', icoil.px));
    end
    if d1==0
        disp(sprintf('Coil d1 has a current of %d A', icoil.d1));
    end
    if d2==0
        disp(sprintf('Coil d2 has a current of %d A', icoil.d2));
    end
    if d3==0
        disp(sprintf('Coil d3 has a current of %d A', icoil.d3));
    end
    if d5==0
        disp(sprintf('Coil d5 has a current of %d A', icoil.d5));
    end
    if d6==0
        disp(sprintf('Coil d6 has a current of %d A', icoil.d6));
    end
    if d7==0
        disp(sprintf('Coil d7 has a current of %d A', icoil.d7));
    end
    if dp==0
        disp(sprintf('Coil dp has a current of %d A', icoil.dp));
    end
end
