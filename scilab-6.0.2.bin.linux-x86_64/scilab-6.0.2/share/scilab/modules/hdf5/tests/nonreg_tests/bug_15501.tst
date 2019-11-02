// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2018 - ESI Group - Cedric Delamarre
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
// <-- CLI SHELL MODE -->
//
// <-- Non-regression test for bug 15501 -->
//
// <-- Bugzilla URL -->
// http://bugzilla.scilab.org/15501
//
// <-- Short Description -->
// listvarinfile() crashes Scilab when listing a cell array (regression)

c = {%z^2, "abc", [%i 3]};
path = TMPDIR+"/test.sod";
save(path, "c");
clear c;
load(path);
listvarinfile(path);
