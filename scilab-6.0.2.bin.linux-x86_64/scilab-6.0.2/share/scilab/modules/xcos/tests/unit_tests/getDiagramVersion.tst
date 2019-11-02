// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) DIGITEO - 2010-2010 - Clément DAVID <clement.david@scilab.org>
//
// This file is distributed under the same license as the Scilab package.

// <-- XCOS TEST -->
//
// <-- Short Description -->
// White-box test for the getDiagramVersion macro.


// empty call check
try
    version = getDiagramVersion();
catch
    [str,n,line,func] = lasterror();
    if func <> "getDiagramVersion" then pause, end;
end

// invalid argument check
try
    version = getDiagramVersion([]);
catch
    [str,n,line,func] = lasterror();
    if func <> "getDiagramVersion" then pause, end;
end

// check that if the version number is filled, then the same value is returned.
scs_m = scicos_diagram();
scs_m.version = "customVersionName";
version = getDiagramVersion(scs_m);
if version <> scs_m.version then pause, end;
