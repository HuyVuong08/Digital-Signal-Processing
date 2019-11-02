// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2018 - Samuel GOUGEON
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// .dia.ref mandatory
// <-- ENGLISH IMPOSED -->

// <-- Non-regression test for bug 15419 -->
//
// <-- Bugzilla URL -->
// http://bugzilla.scilab.org/15419
//
// <-- Short Description -->
// tbx_make(toolbox_skeleton, "localization") silently returned without doing
// nothing when ~/locales is missing

fs = filesep();
path = TMPDIR+fs+"bug_15419";
copyfile(SCI+"/contrib/toolbox_skeleton", path);
loc = path+fs+"locales";
rmdir(loc,"s");
 
tbx_make(path, "localization");

assert_checktrue(isdir(loc));
assert_checktrue(isfile(loc+fs+"en_US.po"));

// Cleaning
rmdir(path, "s");
