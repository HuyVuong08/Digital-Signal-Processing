// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2011 - DIGITEO - Sylvestre Ledru
//
//// This file is distributed under the same license as the Scilab package.
// =============================================================================
//
// <-- TEST WITH GRAPHIC -->
// <-- NOT FIXED -->  6.0.0 -> 6.0.2
//
// <-- Non-regression test for bug 10121 -->
//
// <-- Bugzilla URL -->
// http://bugzilla.scilab.org/show_bug.cgi?id=10121
//
// <-- Short Description -->
//   xsave / xload did not worked with interp_color_vector

plot2d(1:4,cos(1:4));
e=gce(); e=e.children(1);
e.interp_color_vector=[1:4];
xsave("TMPDIR/inter_file.scg");
delete(gcf())
xload("TMPDIR/inter_file.scg");
ef=gce(); ef=ef.children(1).children;
assert_checkequal(ef.interp_color_vector,[1:4]);
delete(gcf())


xload(SCI+"/modules/graphics/tests/nonreg_tests/plot_plein_degrade_xsave.scg");
f=gcf();
assert_checkequal(size(f.children, '*'),1);
delete(gcf())
