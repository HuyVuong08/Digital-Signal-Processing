// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2013 - Scilab Enterprises - Calixte DENIZET
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- TEST WITH GRAPHIC -->

// <-- Non-regression test for bug 8956 -->
//
// <-- Bugzilla URL -->
// http://bugzilla.scilab.org/8956
//
// <-- Short Description -->
// Certains graphics functions did not update data_bounds

// xpoly
clf();
t = linspace(0,2*%pi-%eps);
x = cos(t);
y = sin(t);
xpoly(x,y,"lines",1);
a=gca();
d=a.data_bounds;
assert_checkequal(d, [x(50) y(75);x(1) y(26)]);

// xfpoly
xfpoly([10 20 15],[10 10 20],3)
a=gca();
d=a.data_bounds;
assert_checkequal(d, [10 10;20 20]);

// xrect
clf();
xrect(10, 5, 7, 9);
a=gca();
d=a.data_bounds;
assert_checkequal(d, [10 -4;17 5]);

// xsegs
xsegs([10 20],[10 20],5)
a=gca();
d=a.data_bounds;
assert_checkequal(d, [10 10;20 20]);

// xarc
clf();
xarc(10, 5, 7, 9, 0, 64 * 360);
a=gca();
d=a.data_bounds;
assert_checkequal(d, [10 -4;17 5]);