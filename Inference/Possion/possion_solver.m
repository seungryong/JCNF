function u = possion_solver(f,gx,gy,zx,zy,lambda)

    [X, Y, Zf] = size(f);
    
	N = X*Y;   
    
    fVals = reshape(f,N,Zf);
    C = sparse(1:N,1:N,ones(N,1));
    F = double(fVals);
    
    [~, edges] = lattice(X,Y,0);
    
    gx = double(gx(1:end-1,:));
    gy = double(gy(:,1:end-1));
    weights_g = [gx(:);gy(:)];

    zx = double(zx(1:end-1,:));
    zy = double(zy(:,1:end-1));
    z = -[zx(:);zy(:)];
    
    A0 = C;
    b0 = C*F;
    
    A1 = incidence(edges);
    b1 = weights_g.*z;
    
    A = [A0;lambda*A1];
    b = [b0;lambda*b1];
    
    upper_bound = zeros(length(F),1);
    lower_bound = upper_bound-2;
    U = lsqlin(A,b,[],[],[],[],lower_bound,upper_bound); 
    u = reshape(U,X,Y,Zf); 

end