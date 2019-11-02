// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2017 - Aashay Singhal
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
//
// <-- CLI SHELL MODE -->
//
// <-- Non-regression test for bug 14221 -->
//
// <-- Bugzilla URL -->
// http://bugzilla.scilab.org/14221
//
// <-- Short Description -->
// mprintf("%.1f %% \n", (0:9)') returns only the first output and not the whole list
// same error was also observed with msprintf


mprintf("%.1f %% \n", (0:9)')
msprintf("%.1f %% \n", (0:9)')