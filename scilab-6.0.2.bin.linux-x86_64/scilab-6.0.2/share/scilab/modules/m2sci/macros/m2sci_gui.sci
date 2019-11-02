//
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2002-2008 - INRIA - Vincent COUVERT
//
// Copyright (C) 2012 - 2016 - Scilab Enterprises
//
// This file is hereby licensed under the terms of the GNU GPL v2.0,
// pursuant to article 5.3.4 of the CeCILL v.2.1.
// This file was originally licensed under the terms of the CeCILL v2.1,
// and continues to be available under such terms.
// For more information, see the COPYING file which you should have received
// along with this program.
//

function m2sci_gui()

    // Sizes
    widgeth = 20;
    btnh = 22;
    btnw = 90;
    margin = 18;

    // Figure creation
    m2scifig = figure("figure_name", gettext("Matlab to Scilab conversion tool"),...
    "infobar_visible", "on",...
    "toolbar_visible", "off",...
    "dockable", "off",...
    "menubar", "none",...
    "default_axes", "off",...
    "resize", "off", ..
    "tag", "m2sci_gui");

    h = uimenu("parent", m2scifig, "label", gettext("File"));
    uimenu("parent", h, "label", gettext("Close"), "callback", "cb_m2sci_gui", "tag", "close_menu");

    h = uimenu("parent", m2scifig, "label", gettext("?"));
    uimenu("parent", h, "label", gettext("Mfile2sci help page"), "callback", "cb_m2sci_gui();", "tag", "mfile2sci_help_menu");
    uimenu("parent", h, "label", gettext("Translatepaths help page"), "callback", "cb_m2sci_gui();", "tag", "translatepaths_help_menu");
    uimenu("parent", h, "label", gettext("About M2SCI tools..."), "callback", "cb_m2sci_gui();", "tag", "about_m2sci_menu");

    figw = 650;
    figh = 17*margin + btnh + 7*widgeth;
    m2scifig.axes_size = [figw figh];

    //-------------------
    // --- Validation ---
    //-------------------

    // Convert button
    convertbtn = uicontrol("parent", m2scifig,...
    "style", "pushbutton",...
    "string", gettext("Convert"),...
    "position", [figw-margin-btnw margin btnw btnh],...
    "fontsize", 12,...
    "tag","convertbtn",...
    "callback","cb_m2sci_gui");

    // Cancel button
    cancelbtn = uicontrol("parent", m2scifig,...
    "style", "pushbutton",...
    "string", gettext("Cancel"),...
    "position",[figw-2*margin-2*btnw margin btnw btnh],...
    "fontsize", 12,...
    "tag", "cancelbtn",...
    "callback","cb_m2sci_gui");

    //----------------
    // --- Options ---
    //----------------
    // Frame
    optframe = uicontrol("parent", m2scifig,...
    "style", "frame",...
    "units", "pixels",...
    "border", createBorder("titled", createBorder("line", "lightGray", 1),...
    _("Options"), "left", "top", createBorderFont("", 11, "normal"), "black"),...
    "position", [margin 2*margin+btnh figw-2*margin 5*margin+4*widgeth]);

    // --- Pretty print option ---
    pplabel = uicontrol("parent", m2scifig,...
    "style", "text",...
    "string", gettext("Generate pretty printed code: "),...
    "position",[2*margin 2*margin+btnh+margin 280 widgeth],...
    "horizontalalignment", "left",...
    "fontunits", "points",...
    "fontsize", 12);
    ppradioyes = uicontrol("parent", m2scifig,...
    "style", "radiobutton",...
    "string", gettext("Yes"),...
    "position",[2*margin+300 2*margin+btnh+margin 60 widgeth],...
    "horizontalalignment", "left",...
    "fontunits", "points",...
    "fontsize", 12,...
    "min", 0, ...
    "max", 1, ...
    "value", 0,...
    "callback", "cb_m2sci_gui",...
    "tag", "ppradioyes");
    ppradiono = uicontrol("parent", m2scifig,...
    "style", "radiobutton",...
    "string", gettext("No"),...
    "position",[2*margin+360 2*margin+btnh+margin 60 widgeth],...
    "horizontalalignment", "left",...
    "fontunits", "points",...
    "fontsize", 12,...
    "min", 0, ...
    "max", 1, ...
    "value", 1,...
    "callback", "cb_m2sci_gui",...
    "tag", "ppradiono");

    // --- Verbose option ---
    verby = 2*margin+btnh+margin+widgeth+margin;
    verblabel = uicontrol("parent", m2scifig,...
    "style", "text",...
    "string", gettext("Verbose mode: "),...
    "position",[2*margin verby 280 widgeth],...
    "horizontalalignment", "left",...
    "fontunits", "points",...
    "fontsize", 12);
    verbradio0 = uicontrol("parent", m2scifig,...
    "style", "radiobutton",...
    "string", gettext("0"),...
    "position",[2*margin+300 verby 60 widgeth],...
    "horizontalalignment", "left",...
    "fontunits", "points",...
    "fontsize", 12,...
    "min", 0, ...
    "max", 1, ...
    "value", 0,...
    "callback", "cb_m2sci_gui",...
    "tag", "verbradio0");
    verbradio1 = uicontrol("parent", m2scifig,...
    "style", "radiobutton",...
    "string", gettext("1"),...
    "position",[2*margin+300+60 verby 60 widgeth],...
    "horizontalalignment", "left",...
    "fontunits", "points",...
    "fontsize", 12,...
    "min", 0, ...
    "max", 1, ...
    "value", 0,...
    "callback", "cb_m2sci_gui",...
    "tag", "verbradio1");
    verbradio2 = uicontrol("parent", m2scifig,...
    "style", "radiobutton",...
    "string", gettext("2"),...
    "position",[2*margin+300+60+60 verby 60 widgeth],...
    "horizontalalignment", "left",...
    "fontunits", "points",...
    "fontsize", 12,...
    "min", 0, ...
    "max", 1, ...
    "value", 0,...
    "callback", "cb_m2sci_gui",...
    "tag", "verbradio2");
    verbradio3 = uicontrol("parent", m2scifig,...
    "style", "radiobutton",...
    "string", gettext("3"),...
    "position",[2*margin+300+60+60+60 verby 60 widgeth],...
    "horizontalalignment", "left",...
    "fontunits", "points",...
    "fontsize", 12,...
    "min", 0, ...
    "max", 1, ...
    "value", 1,...
    "callback", "cb_m2sci_gui",...
    "tag", "verbradio3");

    // --- Only doubles option ---
    douby = verby + margin + widgeth;
    doublabel = uicontrol("parent", m2scifig,...
    "style", "text",...
    "string", gettext("Only double values used: "),...
    "position",[2*margin douby 280 widgeth],...
    "horizontalalignment", "left",...
    "fontunits", "points",...
    "fontsize", 12);
    doubradioyes = uicontrol("parent", m2scifig,...
    "style", "radiobutton",...
    "string", gettext("Yes"),...
    "position",[2*margin+300 douby 60 widgeth],...
    "horizontalalignment", "left",...
    "fontunits", "points",...
    "fontsize", 12,...
    "min", 0, ...
    "max", 1, ...
    "value", 0,...
    "callback", "cb_m2sci_gui",...
    "tag", "doubradioyes");
    doubradiono = uicontrol("parent", m2scifig,...
    "style", "radiobutton",...
    "string", gettext("No"),...
    "position",[2*margin+360 douby 60 widgeth],...
    "horizontalalignment", "left",...
    "fontunits", "points",...
    "fontsize", 12,...
    "min", 0, ...
    "max", 1, ...
    "value", 1,...
    "callback", "cb_m2sci_gui",...
    "tag", "doubradiono");

    // --- Recursive mode option ---
    recy = douby + margin + widgeth;
    reclabel = uicontrol("parent", m2scifig,...
    "style", "text",...
    "string", gettext("Recursive conversion: "),...
    "position",[2*margin recy 280 widgeth],...
    "horizontalalignment", "left",...
    "fontunits", "points",...
    "fontsize", 12);
    recradioyes = uicontrol("parent", m2scifig,...
    "style", "radiobutton",...
    "string", gettext("Yes"),...
    "position",[2*margin+300 recy 60 widgeth],...
    "horizontalalignment", "left",...
    "fontunits", "points",...
    "fontsize", 12,...
    "min", 0, ...
    "max", 1, ...
    "value", 0,...
    "callback", "cb_m2sci_gui",...
    "tag", "recradioyes");
    recradiono = uicontrol("parent", m2scifig,...
    "style", "radiobutton",...
    "string", gettext("No"),...
    "position",[2*margin+360 recy 60 widgeth],...
    "horizontalalignment", "left",...
    "fontunits", "points",...
    "fontsize", 12,...
    "min", 0, ...
    "max", 1, ...
    "value", 1,...
    "callback", "cb_m2sci_gui",...
    "tag", "recradiono");

    // ------------------------
    // --- Output directory ---
    // ------------------------
    // Frame
    optframemaxy = 2*margin+btnh + 5*margin+4*widgeth;
    outframe = uicontrol("parent", m2scifig,...
    "style", "frame",...
    "position", [margin optframemaxy+margin figw-2*margin widgeth+2*margin],...
    "border", createBorder("titled", createBorder("line", "lightGray", 1),...
    _("Output directory"),"left","top",createBorderFont("", 11, "normal"), "black"));

    outlabel = uicontrol("parent", m2scifig,...
    "style", "text",...
    "string", gettext("Directory name: "),...
    "position",[2*margin optframemaxy+2*margin-1 120 widgeth],...
    "horizontalalignment", "left",...
    "fontunits", "points",...
    "fontsize", 12);
    outedit = uicontrol("parent", m2scifig,...
    "style", "edit",...
    "string", pwd(),...
    "units", "pixels",...
    "position",[3*margin+100 optframemaxy+2*margin-1 figw-6*margin-100-btnw widgeth],...
    "fontunits", "points",...
    "fontsize", 12, ...
    "tag", "outedit");

    outbtn = uicontrol("parent", m2scifig,...
    "style", "pushbutton",...
    "string", gettext("Browse"),...
    "position",[figw-2*margin-btnw optframemaxy+1.9*margin btnw btnh],...
    "fontsize", 12,...
    "callback", "cb_m2sci_gui",...
    "tag", "outbtn");

    // --------------------------------
    // --- File/Directory selection ---
    // --------------------------------
    // Frame
    outframemaxy = optframemaxy + 2*margin + widgeth + margin;
    selframe = uicontrol("parent", m2scifig,...
    "relief", "groove",...
    "style", "frame",...
    "units", "pixels",...
    "position", [margin outframemaxy+margin figw-2*margin 2*margin+widgeth],...
    "border", createBorder("titled", createBorder("line", "lightGray", 1),...
    _("Input file"),"left","top",createBorderFont("", 11, "normal"), "black"),...
    "tag", "filedirselect");

    // --- Directory selection ---
    dirlabel = uicontrol("parent", m2scifig,...
    "style", "text",...
    "string", gettext("Directory name: "),...
    "position",[2*margin outframemaxy+2*margin-1 120 widgeth],...
    "horizontalalignment", "left",...
    "fontunits", "points",...
    "fontsize", 12,...
    "visible", "off",...
    "tag", "dirlabel");
    diredit = uicontrol("parent", m2scifig,...
    "style", "edit",...
    "string", pwd(),...
    "position",[3*margin+100 outframemaxy+2*margin-1 figw-6*margin-100-btnw widgeth],...
    "fontunits", "points",...
    "fontsize", 12,...
    "tag", "diredit",...
    "visible", "off",...
    "tag", "diredit");
    dirbtn = uicontrol("parent", m2scifig,...
    "style", "pushbutton",...
    "string", gettext("Browse"),...
    "position",[figw-2*margin-btnw outframemaxy+1.9*margin btnw btnh],...
    "fontsize", 12,...
    "visible", "off",...
    "callback", "cb_m2sci_gui",...
    "tag", "dirbtn");

    // --- File selection ---
    filelabel = uicontrol("parent", m2scifig,...
    "style", "text",...
    "string", gettext("File name: "),...
    "position",[2*margin outframemaxy+2*margin-1 120 widgeth],...
    "horizontalalignment", "left",...
    "fontunits", "points",...
    "fontsize", 12,...
    "tag", "filelabel");

    fileedit = uicontrol("parent", m2scifig,...
    "style", "edit",...
    "string", gettext("<enter a file name>"),...
    "position",[3*margin+100 outframemaxy+2*margin-1 figw-6*margin-100-btnw widgeth],...
    "fontunits", "points",...
    "fontsize", 12,...
    "tag", "fileedit");

    filebtn = uicontrol("parent", m2scifig,...
    "style", "pushbutton",...
    "string", gettext("Browse"),...
    "position",[figw-2*margin-btnw outframemaxy+1.9*margin btnw btnh],...
    "fontsize", 12,...
    "callback", "cb_m2sci_gui",...
    "tag", "filebtn");

    // ------------
    // --- Mode ---
    // ------------
    // Frame
    selframemaxy = outframemaxy + 2*margin + widgeth + margin;
    modeframe = uicontrol("parent", m2scifig,...
    "style", "frame",...
    "position", [margin selframemaxy+margin figw-2*margin 2*margin+widgeth],...
    "border", createBorder("titled", createBorder("line", "lightGray", 1),...
    _("Conversion mode"), "left", "top", createBorderFont("", 11, "normal"), "black"));

    fileradio = uicontrol("parent", m2scifig,...
    "style", "radiobutton",...
    "string", gettext("Convert a single file"),...
    "position",[2*margin selframemaxy+2*margin (figw-5*margin)/2 widgeth],...
    "fontunits", "points",...
    "fontsize", 12, ...
    "min", 0, ...
    "max", 1, ...
    "value", 1,...
    "tag", "fileradio", ...
    "callback", "cb_m2sci_gui");

    dirradio = uicontrol("parent", m2scifig,...
    "style", "radiobutton",...
    "string", gettext("Convert a whole directory"),...
    "position",[3*margin+(figw-5*margin)/2 selframemaxy+2*margin (figw-5*margin)/2 widgeth],...
    "fontunits", "points",...
    "fontsize", 12, ...
    "min", 0, ...
    "max", 1, ...
    "value", 0,...
    "tag", "dirradio", ...
    "callback", "cb_m2sci_gui");

endfunction
