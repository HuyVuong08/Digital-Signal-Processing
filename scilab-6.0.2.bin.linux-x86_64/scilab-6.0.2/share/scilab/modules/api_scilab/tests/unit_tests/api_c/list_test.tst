// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2015 - Scilab Enterprises - Antoine ELIAS
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- CLI SHELL MODE -->
ilib_verbose(0);

function test_list(safe)
    mkdir(pathconvert(TMPDIR+"/api_c/" + safe));
    cd(pathconvert(TMPDIR+"/api_c/" + safe));
    copyfile(SCI+"/modules/api_scilab/tests/unit_tests/api_c/list_test.c",pathconvert(TMPDIR+"/api_c/" + safe + "/list_test.c",%F));

    cflags = "";
    if safe == "unsafe" then
        cflags = "-D__API_SCILAB_UNSAFE__";
    end

    ilib_build("liblist" + safe,["list_test","sci_list_test", "csci6"],"list_test.c",[],"","",cflags);
    exec("loader.sce");

    fields = ["double","string","boolean","poly","list","cell"];
    data = list(1, "2", %t, %s, list(1,2,3), {1,2;3,4});
    t = list_test(fields, data);

    assert_checkequal(typeof(t), "mytlist");
    assert_checkequal(t.double, 1);
    assert_checkequal(t.string, "2");
    assert_checkequal(t.boolean, %t);
    assert_checkequal(t.poly, %s);
    assert_checkequal(t.list, list(1,2,3));
    assert_checkequal(t.cell, {1,2;3,4});

    disp("OK");
endfunction

test_list("safe");
test_list("unsafe");
