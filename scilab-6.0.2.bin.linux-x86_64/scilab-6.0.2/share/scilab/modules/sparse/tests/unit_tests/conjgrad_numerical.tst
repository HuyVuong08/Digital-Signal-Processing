// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2013 - Scilab Enterprises - Paul Bignier: added cgs, bicg and bicgstab
// Copyright (C) 2008 - INRIA - Michael Baudin
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
//
// <-- CLI SHELL MODE -->

//------------------------------------------------------------------
// PCG

// Numerical tests
//Well conditionned problem
A=[ 94  0   0   0    0   28  0   0   32  0
0   59  13  5    0   0   0   10  0   0
0   13  72  34   2   0   0   0   0   65
0   5   34  114  0   0   0   0   0   55
0   0   2   0    70  0   28  32  12  0
28  0   0   0    0   87  20  0   33  0
0   0   0   0    28  20  71  39  0   0
0   10  0   0    32  0   39  46  8   0
32  0   0   0    12  33  0   8   82  11
0   0   65  55   0   0   0   0   11  100];
b = [154.
87.
186.
208.
144.
168.
158.
135.
178.
231.];
// With the default 10 iterations, the algorithm performs well
[xcomputed, fail, err, iter, res]=conjgrad(A,b,"pcg");
xexpected=ones(10,1);
if norm(xcomputed-xexpected)>11**3*%eps then pause,end
if fail<>0 then pause,end
if iter<>10 then pause,end
if err > 10**3*%eps then pause,end
// With a tolerance of 1.e-3, there are 5 iterations and the status is "success"
tol=1.d-3;
[xcomputed, fail, err, iter, res]=conjgrad(A,b,"pcg",tol);
if fail<>0 then pause,end
if iter>10 then pause,end
// With a tolerance of %eps but only 5 iterations allowed, the status is "fail"
tol=%eps;
maxIter = 5;
[xcomputed, fail, err, iter, res]=conjgrad(A,b,"pcg",tol,maxIter);
if fail<>1 then pause,end
if iter<>maxIter then pause,end

//------------------------------------------------------------------
// CGS

// CGS needs 11 iterations to converge
[xcomputed, fail, err, iter, res]=conjgrad(A,b,"cgs",maxIter=11);
if norm(xcomputed-xexpected)>100**3*%eps then pause,end
if fail<>0 then pause,end
if iter<>11 then pause,end
if err > 100**3*%eps then pause,end
// With a tolerance of 1.e-3, there are 3 iterations and the status is "success"
tol=1.d-3;
[xcomputed, fail, err, iter, res]=conjgrad(A,b,"cgs",tol);
if fail<>0 then pause,end
if iter>10 then pause,end
// With a tolerance of %eps but only 5 iterations allowed, the status is "fail"
tol=%eps;
maxIter = 5;
[xcomputed, fail, err, iter, res]=conjgrad(A,b,"cgs",tol,maxIter);
if fail<>1 then pause,end
if iter<>maxIter then pause,end

//------------------------------------------------------------------
// BICG

// With the default 10 iterations, the algorithm performs well
[xcomputed, fail, err, iter, res]=conjgrad(A,b,"bicg");
if norm(xcomputed-xexpected)>11**3*%eps then pause,end
if fail<>0 then pause,end
if iter<>10 then pause,end
if err > 10**3*%eps then pause,end
// With a tolerance of 1.e-3, there are 5 iterations and the status is "success"
tol=1.d-3;
[xcomputed, fail, err, iter, res]=conjgrad(A,b,"bicg",tol);
if fail<>0 then pause,end
if iter>10 then pause,end
// With a tolerance of %eps but only 5 iterations allowed, the status is "fail"
tol=%eps;
maxIter = 5;
[xcomputed, fail, err, iter, res]=conjgrad(A,b,"bicg",tol,maxIter);
if fail<>1 then pause,end
if iter<>maxIter then pause,end

//------------------------------------------------------------------
// BICGSTAB

// BICGSTAB only needs 8 iterations to converge to the required tol, but is less accurate on arrival.
[xcomputed, fail, err, iter, res]=conjgrad(A,b,"bicgstab");
if norm(xcomputed-xexpected)>10000**3*%eps then pause,end
if fail<>0 then pause,end
if iter<>8 then pause,end
if err > 1000**3*%eps then pause,end
// With a tolerance of 1.e-3, there are 3 iterations and the status is "success"
tol=1.d-3;
[xcomputed, fail, err, iter, res]=conjgrad(A,b,"bicgstab",tol);
if fail<>0 then pause,end
if iter>10 then pause,end
// With a tolerance of %eps but only 5 iterations allowed, the status is "fail"
tol=%eps;
maxIter = 5;
[xcomputed, fail, err, iter, res]=conjgrad(A,b,"bicgstab",tol,maxIter);
if fail<>1 then pause,end
if iter<>maxIter then pause,end
