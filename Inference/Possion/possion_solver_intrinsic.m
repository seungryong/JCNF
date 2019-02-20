function [u1,u2] = possion_solver_intrinsic(f,lum,gx1,gy1,gx2,gy2,zx1,zy1,zx2,zy2,lambda1,lambda2)
    
    [X, Y, Zf] = size(f);
    
	N = X*Y;   
    
    fVals = reshape(f,N,Zf);
    C = sparse(1:N,1:N,reshape(lum,N,Zf));
    F = double(fVals);
    
    [~, edges] = lattice(X,Y,0);
    
    gx1 = double(gx1(1:end-1,:));
    gy1 = double(gy1(:,1:end-1));
    weights_g1 = [gx1(:);gy1(:)];
    
    gx2 = double(gx2(1:end-1,:));
    gy2 = double(gy2(:,1:end-1));
    weights_g2 = [gx2(:);gy2(:)];

	A0 = [C,C];
    b0 = C*F;

	zx1 = double(zx1(1:end-1,:));
    zy1 = double(zy1(:,1:end-1));
    z1 = -[zx1(:);zy1(:)];
    
    zx2 = double(zx2(1:end-1,:));
    zy2 = double(zy2(:,1:end-1));
    z2 = -[zx2(:);zy2(:)];
    
    n = length(incidence(edges));
    
    A1 = [incidence(edges),sparse(n,N)];
    b1 = weights_g1.*z1;
    
    A2 = [sparse(n,N),incidence(edges)];
    b2 = weights_g2.*z2;
    
    A = [A0;lambda1*A1;lambda2*A2];
    b = [b0;lambda1*b1;lambda2*b2];
    
    upper_bound = zeros(length(F)*2,1);
    lower_bound = upper_bound-2;
    U = lsqlin(A,b,[],[],[],[],lower_bound,upper_bound);
    
    U = full(U);
    u1 = reshape(U(1:N),X,Y,Zf); 
    u2 = reshape(U(N+1:end),X,Y,Zf); 

end