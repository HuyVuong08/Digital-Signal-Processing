// ===========================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2012 - Scilab Enterprises - Calixte DENIZET
//
//  This file is distributed under the same license as the Scilab package.
// ===========================================================================

// <-- CLI SHELL MODE -->

doc = xmlReadStr("<root><a b=""b"" c=""c"" d=""d""><b>b</b></a><c>c</c></root>");
assert_checkequal(size(doc.root.children), [1 2]);
assert_checkequal(size(doc.root.children, "r"), 1);
assert_checkequal(size(doc.root.children, "c"), 2);
assert_checkequal(size(doc.root.children, "*"), 2);

assert_checkequal(size(doc.root.children(1).attributes), [1 3]);
assert_checkequal(size(doc.root.children(1).attributes, "r"), 1);
assert_checkequal(size(doc.root.children(1).attributes, "c"), 3);
assert_checkequal(size(doc.root.children(1).attributes, "*"), 3);

xmlDelete(doc);