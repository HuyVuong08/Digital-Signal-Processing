//<-- CLI SHELL MODE -->
// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2011 - Scilab Enterprises
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

a = [1:10;-(1:10)];
ha = [1:6;-(1:6);3:8;-(3:8)];
assert_checkequal(hank(2,3,a), ha);