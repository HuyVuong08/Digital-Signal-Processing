// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2013 - Scilab Enterprises - Charlotte HECQUET
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
//
// <-- TEST WITH GRAPHIC -->
//
// <-- Non-regression test for bug 12348 -->
//
// <-- Bugzilla URL -->
// http://bugzilla.scilab.org/12348
//
// <-- Short Description -->
// surf() disable lines(n) if there is no input variable.

lines(10)
clf
surf()
ncl=lines();
assert_checkequal(ncl(2),10);
close
