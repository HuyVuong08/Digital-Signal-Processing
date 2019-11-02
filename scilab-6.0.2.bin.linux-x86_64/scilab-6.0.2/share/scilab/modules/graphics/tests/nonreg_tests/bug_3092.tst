// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2008-2008 - INRIA - Jean-Baptiste Silvy
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
// <-- TEST WITH GRAPHIC -->
// <-- NOT FIXED -->   6.0.0  ->  6.0.2
//
// <-- Non-regression test for bug 3092 -->
//
// <-- Bugzilla URL -->
// http://bugzilla.scilab.org/3092
//
// <-- Short Description -->
// clf(<handle>,"reset") doesn't reset the figure size to the default value.

f4=scf(4);
f4.figure_size = [400, 200];
plot2d();
clf(f4,'reset');
defaultFig = gdf();

// check that axes_size are set to default
if (f4.axes_size <> defaultFig.axes_size) then pause; end;

// check that figure is empty
if (f4.children.children <> [] ) then pause; end;


