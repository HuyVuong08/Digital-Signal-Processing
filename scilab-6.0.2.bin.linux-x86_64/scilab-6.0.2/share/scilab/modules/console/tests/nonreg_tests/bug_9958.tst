// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2018 - Samuel GOUGEON
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
// <-- CLI SHELL MODE -->
//
// <-- Non-regression test for bug 9958-->
//
// <-- Bugzilla URL -->
// http://bugzilla.scilab.org/9958
//
// <-- Short Description -->
// mprintf("%d\r", 12345) printed " 345"

mprintf("%d\r", 12345)
