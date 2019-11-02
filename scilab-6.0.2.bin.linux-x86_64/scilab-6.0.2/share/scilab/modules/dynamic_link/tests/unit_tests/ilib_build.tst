// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) ????-2008 - INRIA
// Copyright (C) 2009 - DIGITEO
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- ENGLISH IMPOSED -->
// <-- CLI SHELL MODE -->

TMP_OS_DIR=TMPDIR;

if ~isdir(TMP_OS_DIR) then pause,end;

cur_dir = pwd();

TEST_NAME = "ilib_build_2";
mkdir(TMP_OS_DIR, TEST_NAME);
TEST_DIR_1 = TMP_OS_DIR + filesep() + TEST_NAME;

copyfile(SCI+"/modules/dynamic_link/tests/unit_tests/intfun1.c" , TEST_DIR_1 + filesep() + "intfun1.c");
chdir(TEST_DIR_1);

//creating the shared library (a gateway, a Makefile and a loader are
//generated.
cur_dir = pwd();
chdir(TEST_DIR_1);

files=["intfun1.c"];
ilib_build("foo",["scifun1","intfun1"],files,[]);

// load the shared library
exec loader.sce;

chdir(cur_dir);

//using the new primitive
if ( norm(scifun1(33) - .0160328) > 1 ) then pause,end

chdir(cur_dir);
// ulink() all libraries
ulink();

//remove TMP_DIR
rmdir(TEST_DIR_1,"s");
