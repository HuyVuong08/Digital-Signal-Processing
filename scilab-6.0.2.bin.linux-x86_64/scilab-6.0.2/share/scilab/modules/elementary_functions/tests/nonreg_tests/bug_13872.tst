// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2015 - Scilab Enterprises - Adeline CARNIS
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- CLI SHELL MODE -->

// <-- Non-regression test for bug 13872 -->
//
// <-- Bugzilla URL -->
// http://bugzilla.scilab.org/show_bug.cgi?id=13872
//
// <-- Short Description -->
//    The indices returned by unique were wrong.
// =============================================================================

M1_m=[1.    1.    
    1.    1.    
    1.    1.    
    1.    30.   
    1.    125.  
    1.    199.  
    2.    2.    
    2.    2.    
    2.    2.    
    2.    31. ];

[N1,k1]=unique(M1_m(1:10,1:2),'r');
N2 = [1.    1.  
    1.      30. 
    1.      125. 
    1.      199. 
    2.      2.  
    2.      31. ];
k2 = [1 4 5 6 7 10]';
assert_checkequal(N1, N2);
assert_checkequal(k1, k2);
