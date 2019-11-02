//<-- CLI SHELL MODE -->
// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2009 - INRIA - Serge STEER <serge.steer@inria.fr>
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- Non-regression test for bug 3818 -->
//
// <-- Bugzilla URL -->
// http://bugzilla.scilab.org/show_bug.cgi?id=3818
//
// <-- Short Description -->
// Incorrect syntax error management in control instructions under  execstr( 'errcatch')

if execstr("for k=1:2","errcatch")<>999 then pause,end
if execstr("for k=1:2,k","errcatch")<>999 then pause,end
if execstr("for k=1:","errcatch")<>999 then pause,end
if execstr("for k=[%f %t],k,end","errcatch")<>0 then pause,end


ok=%f;
try
    for k=[%f %t],k,end
catch
    ok=%t;
end
if ok then pause,end
