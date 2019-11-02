//<-- CLI SHELL MODE -->
// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2008-2010 - DIGITEO - Allan CORNET
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

ref1 = [ 0 1 2 3 4 5 6 7 8 9 ;
        10 11 12 13 14 15 16 17 18 19 ;
        20 21 22 23 24 25 26 27 28 29 ;
        30 31 32 33 34 35 36 37 38 39 ;
        40 41 42 43 44 45 46 47 48 49 ];

write_csv(ref1, TMPDIR + '/test.csv');
res = read_csv( TMPDIR + '/test.csv');

if or(evstr(res) <> ref1) then pause, end

write_csv(ref1, TMPDIR + '/test2.csv', ' ', '.');
res = read_csv( TMPDIR + '/test2.csv', ' ');

if or(evstr(res) <> ref1) then pause, end
