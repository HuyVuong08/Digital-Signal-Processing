// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) INRIA/ENPC
// Copyright (C) DIGITEO - 2009-2010 - Allan CORNET
//
// Copyright (C) 2012 - 2016 - Scilab Enterprises
//
// This file is hereby licensed under the terms of the GNU GPL v2.0,
// pursuant to article 5.3.4 of the CeCILL v.2.1.
// This file was originally licensed under the terms of the CeCILL v2.1,
// and continues to be available under such terms.
// For more information, see the COPYING file which you should have received
// along with this program.
//=============================================================================
function ilib_gen_loader(varargin)
    // varargin (max) name, tables, libs, libname, flag, loadername
    [lhs, rhs] = argn(0);

    if and(rhs <> [2 3 6]) then
        error(msprintf(_("%s: Wrong number of input argument(s): %d,%d or %d expected.\n"), "ilib_gen_loader", 2, 3, 6));
    end

    name = varargin(1);
    tables = varargin(2);

    if rhs > 2 then
        libs = varargin(3);
    else
        libs = [];
    end

    if rhs > 3 then
        libname = varargin(4);
    else
        libname = "";
    end

    if rhs > 4 then
        flag = varargin(5);
    else
        flag = "";
    end

    if rhs > 5 then
        loadername = varargin(6);
        if isempty(loadername) then
            loadername = "loader.sce";
        end
    else
        loadername = "loader.sce";
    end

    if type(name) <> 10 then
        error(msprintf(_("%s: Wrong type for input argument #%d: string expected.\n"), "ilib_gen_loader", 1));
    end

    if tables <> [] then
        if type(tables) <> 10 then
            error(msprintf(_("%s: Wrong type for input argument #%d: string expected.\n"), "ilib_gen_loader", 2));
        end
    else
        backupTables = tables;
        if ( typeof(tables) <> "list") then
            tables = list(tables);
        end
        L = length(tables);
        for it = 1:L
            [mt, nt] = size(tables(it));

            if ((mt == 0) & (nt == 0)) then
                break;
            end

            if ( (nt <> 3) & ( nt <> 2) ) then
                error(msprintf(gettext("%s: Wrong size for input argument #%d.\n"),"ilib_gen_loader", 2));
            end
        end
        tables = backupTables;
    end

    if libs <> [] & type(libs) <> 10 then
        error(msprintf(_("%s: Wrong type for input argument #%d: string expected.\n"), "ilib_gen_loader", 3));
    end

    if type(libname) <> 10 then
        error(msprintf(_("%s: Wrong type for input argument #%d: string expected.\n"), "ilib_gen_loader", 4));
    end

    if size(libname,"*") <> 1 then
        error(msprintf(_("%s: Wrong size for input argument #%d: string expected.\n"), "ilib_gen_loader", 4));
    end

    if type(flag) <> 10 then
        error(msprintf(_("%s: Wrong type for input argument #%d: string expected.\n"), "ilib_gen_loader", 5));
    end

    if size(flag,"*") <> 1 then
        error(msprintf(_("%s: Wrong size for input argument #%d: string expected.\n"), "ilib_gen_loader", 5));
    end

    if type(loadername) <> 10 then
        error(msprintf(_("%s: Wrong type for input argument #%d: string expected.\n"), "ilib_gen_loader", 6));
    end

    if size(loadername,"*") <> 1 then
        error(msprintf(_("%s: Wrong size for input argument #%d: string expected.\n"), "ilib_gen_loader", 6));
    end

    if libname == "" then
        libname = name(1);
    end

    generateLoader(name, tables, libs, libname, flag, loadername);

endfunction
//=============================================================================
function bOK = generateLoader(name, tables, libs, libname, flag, loadername)
    bOK = %F;

    if ( length(libname) + length("_path") ) > 24 then
        shortlibname_path = part(libname,1:(24 - length("_path")));
    else
        shortlibname_path = libname;
    end

    [fd, err] = mopen(loadername, "wt");
    if err <> 0 then
        warning(msprintf(_("%s: Cannot open file %s.\n"), "mopen", loadername));
        bOK = %F;
        return
    end

    mfprintf(fd, "// This file is released under the 3-clause BSD license. See COPYING-BSD.\n");
    mfprintf(fd, "// Generated by builder.sce : Please, do not edit this file\n");
    mfprintf(fd, "// ----------------------------------------------------------------------------\n");
    mfprintf(fd, "//\n");

    // Bug 5737
    if getos() == "Windows" then
        if win64() then
            mfprintf(fd, "if ~win64() then\n");
            mfprintf(fd, "  warning(_(""This module requires a Windows x64 platform.""));\n");
        else
            mfprintf(fd, "if win64() then\n");
            mfprintf(fd, "  warning(_(""This module requires a Windows x86 platform.""));\n");
        end
        mfprintf(fd, "  return\n");
        mfprintf(fd, "end\n");
        mfprintf(fd, "//\n");
    end

    // remove path
    filenamewithext = fileparts(loadername,"fname") + fileparts(loadername, "extension");

    mfprintf(fd, "%s_path = get_absolute_file_path(''%s'');\n", shortlibname_path, filenamewithext);
    mfprintf(fd, "//\n");

    // bug 4515 - unlink previous function with same name
    name = name(:)';
    n = size(name, "*");
    mfprintf(fd, "// ulink previous function with same name\n");
    for i = 1:n
        mfprintf(fd, "[bOK, ilib] = c_link(''%s'');\n", name(i));
        mfprintf(fd, "if bOK then\n");
        mfprintf(fd, "  ulink(ilib);\n");
        mfprintf(fd, "end\n");
        mfprintf(fd, "//\n");
    end

    nl = size(libs ,"*");
    for i = 1:nl
        // Add the relative path only if the lib has a relative path
        isabspath = is_absolute_path(libs(i));
        libfile = libs(i);
        if libfile <> "" then
            if isabspath then
                mfprintf(fd, "link(''%s'' + getdynlibext());\n", libfile);
            else
                mfprintf(fd, "link(%s_path + filesep() + ''%s'' + getdynlibext());\n", shortlibname_path, libfile);
            end
        end
    end

    if tables <> [] then
        //
        // addinter
        //
        if ( typeof(tables) <> "list") then
            tables = list(tables);
        end
        L = length(tables);
        if L == 1 then
            // direct call to addinter
            table = tables(1);
            mfprintf(fd, "list_functions = [ ");
            withoutSpace = %T;
            for x = table(1:$,1)'
                if withoutSpace then
                    withoutSpace = %F;
                    mfprintf(fd, "''%s'';\n", x);
                else
                    mfprintf(fd, "                   ''%s'';\n", x);
                end
            end
            mfprintf(fd, "];\n");

            mfprintf(fd, "addinter(%s_path + filesep() + ''%s'' + getdynlibext(), ''%s'', list_functions);\n", shortlibname_path, ..
            name, name);
        else
            // on link then a set of addinter
            mfprintf(fd, "ilib = link(%s_path + filesep() + ''%s'' + getdynlibext());\n", shortlibname_path, ..
            name);
            for itable =1 :L
                // loop on a list of tables
                table = tables(itable);

                mfprintf(fd, "list_functions = [ ''%s'';\n", table(1,1));
                for x = table(2:$, 1)'
                    mfprintf(fd, "                  ''%s'';\n", x);
                end
                mfprintf(fd, "];\n");

                mfprintf(fd, "addinter(ilib, ''%s'', list_functions);\n", ..
                name + string(itable));
            end
        end

    else
        //
        // link
        //
        mfprintf(fd,"link(%s_path + ''lib%s'' + getdynlibext(), [", shortlibname_path, libname);

        for i = 1:n
            mfprintf(fd, "''%s''", name(i));
            if i <> n then
                mfprintf(fd, ",");
            else
                mfprintf(fd, "],");
            end
        end
        mfprintf(fd,"''%s'');\n",flag);
    end

    mfprintf(fd, "// remove temp. variables on stack\n");
    mfprintf(fd,"clear %s_path;\n", shortlibname_path);
    mfprintf(fd,"clear bOK;\n");
    mfprintf(fd,"clear ilib;\n");

    if tables <> [] then
        mfprintf(fd, "clear list_functions;\n");
    end

    mfprintf(fd, "// ----------------------------------------------------------------------------\n");
    mclose(fd);

    if ilib_verbose() > 1 then
        disp(mgetl(loadername));
    end

    bOK = %T;
endfunction
//=============================================================================
