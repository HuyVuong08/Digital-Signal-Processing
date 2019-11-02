// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2013 - Scilab Enterprises - Charlotte HECQUET
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- TEST WITH GRAPHIC -->

// Unit test for plot2d()
x=(0.1:0.1:2*%pi)';
// Error messages with type, size or number of input arguments
errmsg=msprintf(_("%s: Wrong number of mandatory input arguments. At least %d expected.\n"),"plot2d",1);
assert_checkerror("plot2d( logflag=""nn"", style=[-1,-2,3], rect=[0,-2,2*%pi,2], axesflag=1)", errmsg);

errmsg=msprintf(_("%s: Wrong size for input arguments: Incompatible sizes.\n"),"plot2d");
assert_checkerror("plot2d(1, sin(x), logflag=""nn"", style=[-1,-2,3], rect=[0,-2,2*%pi,2], axesflag=1)",errmsg);

errmsg=[msprintf(_("Function not defined for given argument type(s),\n"));msprintf(_("  check arguments or define function %s for overloading.\n"), "%c_plot2d")];
assert_checkerror("plot2d(x, ""s"", logflag=""nn"", style=[-1,-2,3], rect=[0,-2,2*%pi,2], axesflag=1)",errmsg);

// Error messages with log mode
errmsg=msprintf(_("%s: Bounds on y axis must be strictly positive to use logarithmic mode.\n"),"plot2d");
assert_checkerror("plot2d(x, [sin(x)], logflag=""nl"", style=[-1,-2,3], rect=[0,-2,2*%pi,2], axesflag=1)", errmsg);

errmsg=msprintf(_("%s: Bounds on x axis must be strictly positive to use logarithmic mode.\n"),"plot2d");
assert_checkerror("plot2d(x, [sin(x)], logflag=""ln"", style=[-1,-2,3], rect=[0,-2,2*%pi,2], axesflag=1)", errmsg);

errmsg=msprintf(_("%s: Bounds on x axis must be strictly positive to use logarithmic mode.\n"),"plot2d");
assert_checkerror("plot2d(x, [sin(x)], logflag=""ll"", style=[-1,-2,3], rect=[0,-2,2*%pi,2], axesflag=1)", errmsg);

// Error message with rect
errmsg=msprintf(_("%s: Impossible status min > max in x or y rect data.\n"),"plot2d");
assert_checkerror("plot2d(x, sin(x), logflag=""nn"", style=[-1,-2,3], rect=[2,0,2*%pi,-2], axesflag=1)",errmsg);

// Check plot2(x, sin(x))
close
x=(0.1:0.1:2*%pi)';
plot2d(x, sin(x));
f=gcf();
a=gca();
c=a.children(1); //compound
p=c.children(1); //polyline
// Check figure
assert_checkequal(f.auto_resize, "on");
assert_checkequal(f.viewport, [0,0]);
assert_checkequal(f.figure_name, gettext("Graphic window number %d"));
assert_checkequal(f.figure_id, 0);
assert_checkequal(f.pixel_drawing_mode, "copy");
assert_checkequal(f.anti_aliasing, "off");
assert_checkequal(f.immediate_drawing, "on");
assert_checkequal(f.background, -2);
assert_checkequal(f.visible, "on");
assert_checkequal(f.rotation_style, "unary");
assert_checkequal(f.event_handler, "");
assert_checkequal(f.event_handler_enable, "off");
assert_checkequal(f.user_data, []);
assert_checkequal(f.tag, "");
// Check axes
assert_checkequal(a.visible, "on");
assert_checkequal(a.axes_visible, ["on" "on" "on"]);
assert_checkequal(a.axes_reverse, ["off" "off" "off"]);
assert_checkequal(a.grid, [-1 -1]);
assert_checkequal(a.grid_position, "background");
assert_checkequal(a.x_location, "bottom");
assert_checkequal(a.y_location, "left");
assert_checkequal(a.auto_ticks, ["on" "on" "on"]);
assert_checkequal(a.box, "off");
assert_checkequal(a.filled, "on");
assert_checkequal(a.sub_ticks, [0, 1]);
assert_checkequal(a.font_style, 6);
assert_checkequal(a.font_size, 1);
assert_checkequal(a.font_color, -1);
assert_checkequal(a.fractional_font, "off");
assert_checkequal(a.isoview, "off");
assert_checkequal(a.cube_scaling, "off");
assert_checkequal(a.view, "2d");
assert_checkequal(a.rotation_angles, [0, 270]);
assert_checkequal(a.log_flags, "nnn");
assert_checkequal(a.tight_limits, ["off", "off", "off"]);
assert_checktrue(a.data_bounds - [1,-0.9999233;63,0.9995736] < 1d-7);
assert_checkequal(a.zoom_box, []);
assert_checkequal(a.margins, [0.125, 0.125, 0.125, 0.125]);
assert_checkequal(a.axes_bounds, [0, 0, 1, 1]);
assert_checkequal(a.auto_clear, "off");
assert_checkequal(a.auto_scale, "on");
assert_checkequal(a.hidden_axis_color, 4);
assert_checkequal(a.hiddencolor, 4);
assert_checkequal(a.line_mode, "on");
assert_checkequal(a.line_style, 1);
assert_checkequal(a.thickness, 1);
assert_checkequal(a.mark_mode, "off");
assert_checkequal(a.mark_style, 0);
assert_checkequal(a.mark_size_unit, "tabulated");
assert_checkequal(a.mark_size, 0);
assert_checkequal(a.mark_foreground, -1);
assert_checkequal(a.mark_background, -2);
assert_checkequal(a.foreground, -1);
assert_checkequal(a.background, -2);
assert_checkequal(a.arc_drawing_method, "lines");
assert_checkequal(a.clip_state, "clipgrf");
assert_checkequal(a.clip_box, []);
assert_checkequal(a.user_data, []);
// Check compound
assert_checkequal(c.parent.type, "Axes");
assert_checkequal(c.children(:).type, "Polyline");
assert_checkequal(c.visible, "on");
assert_checkequal(c.user_data, []);
// Check polyline
DefaultData=(0.1:0.1:2*%pi)';
assert_checkequal(p.parent.type, "Compound");
assert_checkequal(p.children, []);
assert_checkequal(p.visible, "on");
assert_checkequal(p.data, [DefaultData, sin(DefaultData)]);
assert_checkequal(p.closed, "off");
assert_checkequal(p.line_mode, "on");
assert_checkequal(p.fill_mode, "off");
assert_checkequal(p.line_style, 1);
assert_checkequal(p.thickness, 1);
assert_checkequal(p.arrow_size_factor, 1);
assert_checkequal(p.polyline_style, 1);
assert_checkequal(p.foreground, 1);
assert_checkequal(p.background, -2);
assert_checkequal(p.interp_color_vector, []);
assert_checkequal(p.interp_color_mode, "off");
assert_checkequal(p.mark_mode, "off");
assert_checkequal(p.mark_style, 0);
assert_checkequal(p.mark_size_unit, "tabulated");
assert_checkequal(p.mark_size, 0);
assert_checkequal(p.mark_foreground, -1);
assert_checkequal(p.mark_background, -2);
assert_checkequal(p.x_shift, []);
assert_checkequal(p.y_shift, []);
assert_checkequal(p.z_shift, []);
assert_checkequal(p.bar_width, 0);
assert_checkequal(p.clip_state, "clipgrf");
assert_checkequal(p.clip_box, []);
assert_checkequal(p.user_data, []);

// Check plot2d(x, sin(x), loglag="nl")
close
x=(0.1:0.1:2*%pi)';
plot2d(x, sin(x), logflag="nl");
f=gcf();
a=gca();
c=a.children(1); //compound
p=c.children(1); //polyline
// Check figure
assert_checkequal(f.auto_resize, "on");
assert_checkequal(f.viewport, [0,0]);
assert_checkequal(f.figure_name, gettext("Graphic window number %d"));
assert_checkequal(f.figure_id, 0);
assert_checkequal(f.pixel_drawing_mode, "copy");
assert_checkequal(f.anti_aliasing, "off");
assert_checkequal(f.immediate_drawing, "on");
assert_checkequal(f.background, -2);
assert_checkequal(f.visible, "on");
assert_checkequal(f.rotation_style, "unary");
assert_checkequal(f.event_handler, "");
assert_checkequal(f.event_handler_enable, "off");
assert_checkequal(f.user_data, []);
assert_checkequal(f.tag, "");
// Check axes
assert_checkequal(a.visible, "on");
assert_checkequal(a.axes_visible, ["on" "on" "on"]);
assert_checkequal(a.axes_reverse, ["off" "off" "off"]);
assert_checkequal(a.grid, [-1 -1]);
assert_checkequal(a.grid_position, "background");
assert_checkequal(a.x_location, "bottom");
assert_checkequal(a.y_location, "left");
assert_checkequal(a.auto_ticks, ["on" "on" "on"]);
assert_checkequal(a.box, "off");
assert_checkequal(a.filled, "on");
assert_checkequal(a.sub_ticks, [0, 4]);
assert_checkequal(a.font_style, 6);
assert_checkequal(a.font_size, 1);
assert_checkequal(a.font_color, -1);
assert_checkequal(a.fractional_font, "off");
assert_checkequal(a.isoview, "off");
assert_checkequal(a.cube_scaling, "off");
assert_checkequal(a.view, "2d");
assert_checkequal(a.rotation_angles, [0, 270]);
assert_checkequal(a.log_flags, "nln");
assert_checkequal(a.tight_limits, ["off", "off", "off"]);
assert_checktrue(a.data_bounds - [0.1, 0.0415807; 6.2, 0.9995736] < 1d-7);
assert_checkequal(a.zoom_box, []);
assert_checkequal(a.margins, [0.125, 0.125, 0.125, 0.125]);
assert_checkequal(a.axes_bounds, [0, 0, 1, 1]);
assert_checkequal(a.auto_clear, "off");
assert_checkequal(a.auto_scale, "on");
assert_checkequal(a.hidden_axis_color, 4);
assert_checkequal(a.hiddencolor, 4);
assert_checkequal(a.line_mode, "on");
assert_checkequal(a.line_style, 1);
assert_checkequal(a.thickness, 1);
assert_checkequal(a.mark_mode, "off");
assert_checkequal(a.mark_style, 0);
assert_checkequal(a.mark_size_unit, "tabulated");
assert_checkequal(a.mark_size, 0);
assert_checkequal(a.mark_foreground, -1);
assert_checkequal(a.mark_background, -2);
assert_checkequal(a.foreground, -1);
assert_checkequal(a.background, -2);
assert_checkequal(a.arc_drawing_method, "lines");
assert_checkequal(a.clip_state, "clipgrf");
assert_checkequal(a.clip_box, []);
assert_checkequal(a.user_data, []);
// Check compound
assert_checkequal(c.parent.type, "Axes");
assert_checkequal(c.children(:).type, "Polyline");
assert_checkequal(c.visible, "on");
assert_checkequal(c.user_data, []);
// Check polyline
DefaultData=(0.1:0.1:2*%pi)';
assert_checkequal(p.parent.type, "Compound");
assert_checkequal(p.children, []);
assert_checkequal(p.visible, "on");
assert_checkequal(p.data, [DefaultData, sin(DefaultData)]);
assert_checkequal(p.closed, "off");
assert_checkequal(p.line_mode, "on");
assert_checkequal(p.fill_mode, "off");
assert_checkequal(p.line_style, 1);
assert_checkequal(p.thickness, 1);
assert_checkequal(p.arrow_size_factor, 1);
assert_checkequal(p.polyline_style, 1);
assert_checkequal(p.foreground, 1);
assert_checkequal(p.background, -2);
assert_checkequal(p.interp_color_vector, []);
assert_checkequal(p.interp_color_mode, "off");
assert_checkequal(p.mark_mode, "off");
assert_checkequal(p.mark_style, 0);
assert_checkequal(p.mark_size_unit, "tabulated");
assert_checkequal(p.mark_size, 0);
assert_checkequal(p.mark_foreground, -1);
assert_checkequal(p.mark_background, -2);
assert_checkequal(p.x_shift, []);
assert_checkequal(p.y_shift, []);
assert_checkequal(p.z_shift, []);
assert_checkequal(p.bar_width, 0);
assert_checkequal(p.clip_state, "clipgrf");
assert_checkequal(p.clip_box, []);
assert_checkequal(p.user_data, []);

// Check plot2d(x, sin(x), logflag="ln")
close
x=(0.1:0.1:2*%pi)';
plot2d(x, sin(x), logflag="ln");
f=gcf();
a=gca();
c=a.children(1); //compound
p=c.children(1); //polyline
// Check sub_ticks
assert_checkequal(a.sub_ticks, [3, 1]);
// Check data_bounds
assert_checktrue(a.data_bounds - [0.1, - 0.9999233 ; 6.2, 0.9995736] < 1d-7);
// Check logflags
assert_checkequal(a.log_flags, "lnn");
// Check data
assert_checkequal(p.data, [DefaultData, sin(DefaultData)]);

// Check plot2d(x, sin(x), logflag="ll")
close
x=(0.1:0.1:2*%pi)';
plot2d(x, sin(x), logflag="ll");
f=gcf();
a=gca();
c=a.children(1); //compound
p=c.children(1); //polyline
// Check sub_ticks
assert_checkequal(a.sub_ticks, [3, 4]);
// Check data_bounds
assert_checktrue(a.data_bounds - [0.1, 0.0415807 ; 6.2, 0.9995736] < 1d-7);
// Check logflags
assert_checkequal(a.log_flags, "lln");
// Check data
assert_checkequal(p.data, [DefaultData, sin(DefaultData)]);

// Check style=[-1,-2,-3,-4]
close
x=(0.1:0.1:2*%pi)';
plot2d(x, [sin(x),sin(2*x), sin(3*x), sin(4*x)], style=[-1,-2,-3,-4]);
f=gcf();
a=gca();
c=a.children(1); //compound
p1=c.children(1); //polyline 1
p2=c.children(2); //polyline 2
p3=c.children(3); //polyline 3
p4=c.children(4); //polyline 4
// Check polyline 1
DefaultData=(0.1:0.1:2*%pi)';
assert_checkequal(p1.parent.type, "Compound");
assert_checkequal(p1.children, []);
assert_checkequal(p1.visible, "on");
assert_checkequal(p1.data, [DefaultData, sin(4*DefaultData)]);
assert_checkequal(p1.closed, "off");
assert_checkequal(p1.line_mode, "off");
assert_checkequal(p1.fill_mode, "off");
assert_checkequal(p1.line_style, 1);
assert_checkequal(p1.thickness, 1);
assert_checkequal(p1.arrow_size_factor, 1);
assert_checkequal(p1.polyline_style, 1);
assert_checkequal(p1.foreground, -1);
assert_checkequal(p1.background, -2);
assert_checkequal(p1.interp_color_vector, []);
assert_checkequal(p1.interp_color_mode, "off");
assert_checkequal(p1.mark_mode, "on");
assert_checkequal(p1.mark_style, 4);
assert_checkequal(p1.mark_size_unit, "tabulated");
assert_checkequal(p1.mark_size, 0);
assert_checkequal(p1.mark_foreground, -1);
assert_checkequal(p1.mark_background, -2);
assert_checkequal(p1.x_shift, []);
assert_checkequal(p1.y_shift, []);
assert_checkequal(p1.z_shift, []);
assert_checkequal(p1.bar_width, 0);
assert_checkequal(p1.clip_state, "clipgrf");
assert_checkequal(p1.clip_box, []);
assert_checkequal(p1.user_data, []);
// Check polyline 2;
assert_checkequal(p2.parent.type, "Compound");
assert_checkequal(p2.children, []);
assert_checkequal(p2.visible, "on");
assert_checkequal(p2.data, [DefaultData, sin(3*DefaultData)]);
assert_checkequal(p2.closed, "off");
assert_checkequal(p2.line_mode, "off");
assert_checkequal(p2.fill_mode, "off");
assert_checkequal(p2.line_style, 1);
assert_checkequal(p2.thickness, 1);
assert_checkequal(p2.arrow_size_factor, 1);
assert_checkequal(p2.polyline_style, 1);
assert_checkequal(p2.foreground, -1);
assert_checkequal(p2.background, -2);
assert_checkequal(p2.interp_color_vector, []);
assert_checkequal(p2.interp_color_mode, "off");
assert_checkequal(p2.mark_mode, "on");
assert_checkequal(p2.mark_style, 3);
assert_checkequal(p2.mark_size_unit, "tabulated");
assert_checkequal(p2.mark_size, 0);
assert_checkequal(p2.mark_foreground, -1);
assert_checkequal(p2.mark_background, -2);
assert_checkequal(p2.x_shift, []);
assert_checkequal(p2.y_shift, []);
assert_checkequal(p2.z_shift, []);
assert_checkequal(p2.bar_width, 0);
assert_checkequal(p2.clip_state, "clipgrf");
assert_checkequal(p2.clip_box, []);
assert_checkequal(p2.user_data, []);
// Check polyline 3;
assert_checkequal(p3.parent.type, "Compound");
assert_checkequal(p3.children, []);
assert_checkequal(p3.visible, "on");
assert_checkequal(p3.data, [DefaultData, sin(2*DefaultData)]);
assert_checkequal(p3.closed, "off");
assert_checkequal(p3.line_mode, "off");
assert_checkequal(p3.fill_mode, "off");
assert_checkequal(p3.line_style, 1);
assert_checkequal(p3.thickness, 1);
assert_checkequal(p3.arrow_size_factor, 1);
assert_checkequal(p3.polyline_style, 1);
assert_checkequal(p3.foreground, -1);
assert_checkequal(p3.background, -2);
assert_checkequal(p3.interp_color_vector, []);
assert_checkequal(p3.interp_color_mode, "off");
assert_checkequal(p3.mark_mode, "on");
assert_checkequal(p3.mark_style, 2);
assert_checkequal(p3.mark_size_unit, "tabulated");
assert_checkequal(p3.mark_size, 0);
assert_checkequal(p3.mark_foreground, -1);
assert_checkequal(p3.mark_background, -2);
assert_checkequal(p3.x_shift, []);
assert_checkequal(p3.y_shift, []);
assert_checkequal(p3.z_shift, []);
assert_checkequal(p3.bar_width, 0);
assert_checkequal(p3.clip_state, "clipgrf");
assert_checkequal(p3.clip_box, []);
assert_checkequal(p3.user_data, []);
// Check polyline 4;
assert_checkequal(p4.parent.type, "Compound");
assert_checkequal(p4.children, []);
assert_checkequal(p4.visible, "on");
assert_checkequal(p4.data, [DefaultData, sin(DefaultData)]);
assert_checkequal(p4.closed, "off");
assert_checkequal(p4.line_mode, "off");
assert_checkequal(p4.fill_mode, "off");
assert_checkequal(p4.line_style, 1);
assert_checkequal(p4.thickness, 1);
assert_checkequal(p4.arrow_size_factor, 1);
assert_checkequal(p4.polyline_style, 1);
assert_checkequal(p4.foreground, -1);
assert_checkequal(p4.background, -2);
assert_checkequal(p4.interp_color_vector, []);
assert_checkequal(p4.interp_color_mode, "off");
assert_checkequal(p4.mark_mode, "on");
assert_checkequal(p4.mark_style, 1);
assert_checkequal(p4.mark_size_unit, "tabulated");
assert_checkequal(p4.mark_size, 0);
assert_checkequal(p4.mark_foreground, -1);
assert_checkequal(p4.mark_background, -2);
assert_checkequal(p4.x_shift, []);
assert_checkequal(p4.y_shift, []);
assert_checkequal(p4.z_shift, []);
assert_checkequal(p4.bar_width, 0);
assert_checkequal(p4.clip_state, "clipgrf");
assert_checkequal(p4.clip_box, []);
assert_checkequal(p4.user_data, []);

// Check rect=[0,-2,2*%pi,2]
close
x=(0.1:0.1:2*%pi)';
plot2d(x, sin(x), rect=[0,-2,2*%pi,2]);
f=gcf();
a=gca();
c=a.children(1); //compound
p=c.children(1); //polyline
// Check axes
assert_checkequal(a.visible, "on");
assert_checkequal(a.axes_visible, ["on" "on" "on"]);
assert_checkequal(a.axes_reverse, ["off" "off" "off"]);
assert_checkequal(a.grid, [-1 -1]);
assert_checkequal(a.grid_position, "background");
assert_checkequal(a.x_location, "bottom");
assert_checkequal(a.y_location, "left");
assert_checkequal(a.auto_ticks, ["on" "on" "on"]);
assert_checkequal(a.box, "off");
assert_checkequal(a.filled, "on");
assert_checkequal(a.sub_ticks, [0, 4]);
assert_checkequal(a.font_style, 6);
assert_checkequal(a.font_size, 1);
assert_checkequal(a.font_color, -1);
assert_checkequal(a.fractional_font, "off");
assert_checkequal(a.isoview, "off");
assert_checkequal(a.cube_scaling, "off");
assert_checkequal(a.view, "2d");
assert_checkequal(a.rotation_angles, [0, 270]);
assert_checkequal(a.log_flags, "nnn");
assert_checkequal(a.tight_limits, ["on", "on", "on"]);
assert_checkequal(a.data_bounds, [0, -2; 2*%pi, 2]);
assert_checkequal(a.zoom_box, []);
assert_checkequal(a.margins, [0.125, 0.125, 0.125, 0.125]);
assert_checkequal(a.axes_bounds, [0, 0, 1, 1]);
assert_checkequal(a.auto_clear, "off");
assert_checkequal(a.auto_scale, "on");
assert_checkequal(a.hidden_axis_color, 4);
assert_checkequal(a.hiddencolor, 4);
assert_checkequal(a.line_mode, "on");
assert_checkequal(a.line_style, 1);
assert_checkequal(a.thickness, 1);
assert_checkequal(a.mark_mode, "off");
assert_checkequal(a.mark_style, 0);
assert_checkequal(a.mark_size_unit, "tabulated");
assert_checkequal(a.mark_size, 0);
assert_checkequal(a.mark_foreground, -1);
assert_checkequal(a.mark_background, -2);
assert_checkequal(a.foreground, -1);
assert_checkequal(a.background, -2);
assert_checkequal(a.arc_drawing_method, "lines");
assert_checkequal(a.clip_state, "clipgrf");
assert_checkequal(a.clip_box, []);
assert_checkequal(a.user_data, []);
// Check compound
assert_checkequal(c.parent.type, "Axes");
assert_checkequal(c.children(:).type, "Polyline");
assert_checkequal(c.visible, "on");
assert_checkequal(c.user_data, []);
// Check polyline
DefaultData=(0.1:0.1:2*%pi)';
assert_checkequal(p.parent.type, "Compound");
assert_checkequal(p.children, []);
assert_checkequal(p.visible, "on");
assert_checkequal(p.data, [DefaultData, sin(DefaultData)]);
assert_checkequal(p.closed, "off");
assert_checkequal(p.line_mode, "on");
assert_checkequal(p.fill_mode, "off");
assert_checkequal(p.line_style, 1);
assert_checkequal(p.thickness, 1);
assert_checkequal(p.arrow_size_factor, 1);
assert_checkequal(p.polyline_style, 1);
assert_checkequal(p.foreground, 1);
assert_checkequal(p.background, -2);
assert_checkequal(p.interp_color_vector, []);
assert_checkequal(p.interp_color_mode, "off");
assert_checkequal(p.mark_mode, "off");
assert_checkequal(p.mark_style, 0);
assert_checkequal(p.mark_size_unit, "tabulated");
assert_checkequal(p.mark_size, 0);
assert_checkequal(p.mark_foreground, -1);
assert_checkequal(p.mark_background, -2);
assert_checkequal(p.x_shift, []);
assert_checkequal(p.y_shift, []);
assert_checkequal(p.z_shift, []);
assert_checkequal(p.bar_width, 0);
assert_checkequal(p.clip_state, "clipgrf");
assert_checkequal(p.clip_box, []);
assert_checkequal(p.user_data, []);

// Check axesflag=1
close
x=(0.1:0.1:2*%pi)';
plot2d(x, sin(x), axesflag=1);
f=gcf();
a=gca();
c=a.children(1); //compound
p=c.children(1); //polyline
// Check axes
assert_checkequal(a.visible, "on");
assert_checkequal(a.axes_visible, ["on" "on" "on"]);
assert_checkequal(a.axes_reverse, ["off" "off" "off"]);
assert_checkequal(a.grid, [-1 -1]);
assert_checkequal(a.grid_position, "background");
assert_checkequal(a.x_location, "bottom");
assert_checkequal(a.y_location, "left");
assert_checkequal(a.auto_ticks, ["on" "on" "on"]);
assert_checkequal(a.box, "on");
assert_checkequal(a.filled, "on");
assert_checkequal(a.sub_ticks, [0, 1]);
assert_checkequal(a.font_style, 6);
assert_checkequal(a.font_size, 1);
assert_checkequal(a.font_color, -1);
assert_checkequal(a.fractional_font, "off");
assert_checkequal(a.isoview, "off");
assert_checkequal(a.cube_scaling, "off");
assert_checkequal(a.view, "2d");
assert_checkequal(a.rotation_angles, [0, 270]);
assert_checkequal(a.log_flags, "nnn");
assert_checkequal(a.tight_limits, ["off", "off", "off"]);
assert_checktrue(a.data_bounds - [0.1, 0.0415807; 6.2, 0.9995736] < 1d-7);
assert_checkequal(a.zoom_box, []);
assert_checkequal(a.margins, [0.125, 0.125, 0.125, 0.125]);
assert_checkequal(a.axes_bounds, [0, 0, 1, 1]);
assert_checkequal(a.auto_clear, "off");
assert_checkequal(a.auto_scale, "on");
assert_checkequal(a.hidden_axis_color, 4);
assert_checkequal(a.hiddencolor, 4);
assert_checkequal(a.line_mode, "on");
assert_checkequal(a.line_style, 1);
assert_checkequal(a.thickness, 1);
assert_checkequal(a.mark_mode, "off");
assert_checkequal(a.mark_style, 0);
assert_checkequal(a.mark_size_unit, "tabulated");
assert_checkequal(a.mark_size, 0);
assert_checkequal(a.mark_foreground, -1);
assert_checkequal(a.mark_background, -2);
assert_checkequal(a.foreground, -1);
assert_checkequal(a.background, -2);
assert_checkequal(a.arc_drawing_method, "lines");
assert_checkequal(a.clip_state, "clipgrf");
assert_checkequal(a.clip_box, []);
assert_checkequal(a.user_data, []);
// Check axesflag=2
close
x=(0.1:0.1:2*%pi)';
plot2d(x, sin(x), axesflag=2);
f=gcf();
a=gca();
c=a.children(1); //compound
p=c.children(1); //polyline
// Check axes
assert_checkequal(a.visible, "on");
assert_checkequal(a.axes_visible, ["off" "off" "off"]);
assert_checkequal(a.axes_reverse, ["off" "off" "off"]);
assert_checkequal(a.grid, [-1 -1]);
assert_checkequal(a.grid_position, "background");
assert_checkequal(a.x_location, "bottom");
assert_checkequal(a.y_location, "left");
assert_checkequal(a.auto_ticks, ["on" "on" "on"]);
assert_checkequal(a.box, "on");
assert_checkequal(a.filled, "on");
assert_checkequal(a.sub_ticks, [1, 1]);
assert_checkequal(a.font_style, 6);
assert_checkequal(a.font_size, 1);
assert_checkequal(a.font_color, -1);
assert_checkequal(a.fractional_font, "off");
assert_checkequal(a.isoview, "off");
assert_checkequal(a.cube_scaling, "off");
assert_checkequal(a.view, "2d");
assert_checkequal(a.rotation_angles, [0, 270]);
assert_checkequal(a.log_flags, "nnn");
assert_checkequal(a.tight_limits, ["off", "off", "off"]);
assert_checktrue(a.data_bounds - [0.1, 0.0415807; 6.2, 0.9995736] < 1d-7);
assert_checkequal(a.zoom_box, []);
assert_checkequal(a.margins, [0.125, 0.125, 0.125, 0.125]);
assert_checkequal(a.axes_bounds, [0, 0, 1, 1]);
assert_checkequal(a.auto_clear, "off");
assert_checkequal(a.auto_scale, "on");
assert_checkequal(a.hidden_axis_color, 4);
assert_checkequal(a.hiddencolor, 4);
assert_checkequal(a.line_mode, "on");
assert_checkequal(a.line_style, 1);
assert_checkequal(a.thickness, 1);
assert_checkequal(a.mark_mode, "off");
assert_checkequal(a.mark_style, 0);
assert_checkequal(a.mark_size_unit, "tabulated");
assert_checkequal(a.mark_size, 0);
assert_checkequal(a.mark_foreground, -1);
assert_checkequal(a.mark_background, -2);
assert_checkequal(a.foreground, -1);
assert_checkequal(a.background, -2);
assert_checkequal(a.arc_drawing_method, "lines");
assert_checkequal(a.clip_state, "clipgrf");
assert_checkequal(a.clip_box, []);
assert_checkequal(a.user_data, []);
// Check axesflag=3
close
x=(0.1:0.1:2*%pi)';
plot2d(x, sin(x), axesflag=3);
f=gcf();
a=gca();
c=a.children(1); //compound
p=c.children(1); //polyline
// Check axes
assert_checkequal(a.visible, "on");
assert_checkequal(a.axes_visible, ["on" "on" "on"]);
assert_checkequal(a.axes_reverse, ["off" "off" "off"]);
assert_checkequal(a.grid, [-1 -1]);
assert_checkequal(a.grid_position, "background");
assert_checkequal(a.x_location, "bottom");
assert_checkequal(a.y_location, "right");
assert_checkequal(a.auto_ticks, ["on" "on" "on"]);
assert_checkequal(a.box, "off");
assert_checkequal(a.filled, "on");
assert_checkequal(a.sub_ticks, [0, 1]);
assert_checkequal(a.font_style, 6);
assert_checkequal(a.font_size, 1);
assert_checkequal(a.font_color, -1);
assert_checkequal(a.fractional_font, "off");
assert_checkequal(a.isoview, "off");
assert_checkequal(a.cube_scaling, "off");
assert_checkequal(a.view, "2d");
assert_checkequal(a.rotation_angles, [0, 270]);
assert_checkequal(a.log_flags, "nnn");
assert_checkequal(a.tight_limits, ["off", "off", "off"]);
assert_checktrue(a.data_bounds - [0.1, 0.0415807; 6.2, 0.9995736] < 1d-7);
assert_checkequal(a.zoom_box, []);
assert_checkequal(a.margins, [0.125, 0.125, 0.125, 0.125]);
assert_checkequal(a.axes_bounds, [0, 0, 1, 1]);
assert_checkequal(a.auto_clear, "off");
assert_checkequal(a.auto_scale, "on");
assert_checkequal(a.hidden_axis_color, 4);
assert_checkequal(a.hiddencolor, 4);
assert_checkequal(a.line_mode, "on");
assert_checkequal(a.line_style, 1);
assert_checkequal(a.thickness, 1);
assert_checkequal(a.mark_mode, "off");
assert_checkequal(a.mark_style, 0);
assert_checkequal(a.mark_size_unit, "tabulated");
assert_checkequal(a.mark_size, 0);
assert_checkequal(a.mark_foreground, -1);
assert_checkequal(a.mark_background, -2);
assert_checkequal(a.foreground, -1);
assert_checkequal(a.background, -2);
assert_checkequal(a.arc_drawing_method, "lines");
assert_checkequal(a.clip_state, "clipgrf");
assert_checkequal(a.clip_box, []);
assert_checkequal(a.user_data, []);
// Check axesflag=4
close
x=(0.1:0.1:2*%pi)';
plot2d(x, sin(x), axesflag=4);
f=gcf();
a=gca();
c=a.children(1); //compound
p=c.children(1); //polyline
// Check axes
assert_checkequal(a.visible, "on");
assert_checkequal(a.axes_visible, ["on" "on" "on"]);
assert_checkequal(a.axes_reverse, ["off" "off" "off"]);
assert_checkequal(a.grid, [-1 -1]);
assert_checkequal(a.grid_position, "background");
assert_checkequal(a.x_location, "middle");
assert_checkequal(a.y_location, "middle");
assert_checkequal(a.auto_ticks, ["on" "on" "on"]);
assert_checkequal(a.box, "off");
assert_checkequal(a.filled, "on");
assert_checkequal(a.sub_ticks, [0, 1]);
assert_checkequal(a.font_style, 6);
assert_checkequal(a.font_size, 1);
assert_checkequal(a.font_color, -1);
assert_checkequal(a.fractional_font, "off");
assert_checkequal(a.isoview, "off");
assert_checkequal(a.cube_scaling, "off");
assert_checkequal(a.view, "2d");
assert_checkequal(a.rotation_angles, [0, 270]);
assert_checkequal(a.log_flags, "nnn");
assert_checkequal(a.tight_limits, ["off", "off", "off"]);
assert_checktrue(a.data_bounds - [0.1, 0.0415807; 6.2, 0.9995736] < 1d-7);
assert_checkequal(a.zoom_box, []);
assert_checkequal(a.margins, [0.125, 0.125, 0.125, 0.125]);
assert_checkequal(a.axes_bounds, [0, 0, 1, 1]);
assert_checkequal(a.auto_clear, "off");
assert_checkequal(a.auto_scale, "on");
assert_checkequal(a.hidden_axis_color, 4);
assert_checkequal(a.hiddencolor, 4);
assert_checkequal(a.line_mode, "on");
assert_checkequal(a.line_style, 1);
assert_checkequal(a.thickness, 1);
assert_checkequal(a.mark_mode, "off");
assert_checkequal(a.mark_style, 0);
assert_checkequal(a.mark_size_unit, "tabulated");
assert_checkequal(a.mark_size, 0);
assert_checkequal(a.mark_foreground, -1);
assert_checkequal(a.mark_background, -2);
assert_checkequal(a.foreground, -1);
assert_checkequal(a.background, -2);
assert_checkequal(a.arc_drawing_method, "lines");
assert_checkequal(a.clip_state, "clipgrf");
assert_checkequal(a.clip_box, []);
assert_checkequal(a.user_data, []);
// Check axesflag=5
close
x=(0.1:0.1:2*%pi)';
plot2d(x, sin(x), axesflag=5);
f=gcf();
a=gca();
c=a.children(1); //compound
p=c.children(1); //polyline
// Check axes
assert_checkequal(a.visible, "on");
assert_checkequal(a.axes_visible, ["on" "on" "on"]);
assert_checkequal(a.axes_reverse, ["off" "off" "off"]);
assert_checkequal(a.grid, [-1 -1]);
assert_checkequal(a.grid_position, "background");
assert_checkequal(a.x_location, "middle");
assert_checkequal(a.y_location, "middle");
assert_checkequal(a.auto_ticks, ["on" "on" "on"]);
assert_checkequal(a.box, "on");
assert_checkequal(a.filled, "on");
assert_checkequal(a.sub_ticks, [0, 1]);
assert_checkequal(a.font_style, 6);
assert_checkequal(a.font_size, 1);
assert_checkequal(a.font_color, -1);
assert_checkequal(a.fractional_font, "off");
assert_checkequal(a.isoview, "off");
assert_checkequal(a.cube_scaling, "off");
assert_checkequal(a.view, "2d");
assert_checkequal(a.rotation_angles, [0, 270]);
assert_checkequal(a.log_flags, "nnn");
assert_checkequal(a.tight_limits, ["off", "off", "off"]);
assert_checktrue(a.data_bounds - [0.1, 0.0415807; 6.2, 0.9995736] < 1d-7);
assert_checkequal(a.zoom_box, []);
assert_checkequal(a.margins, [0.125, 0.125, 0.125, 0.125]);
assert_checkequal(a.axes_bounds, [0, 0, 1, 1]);
assert_checkequal(a.auto_clear, "off");
assert_checkequal(a.auto_scale, "on");
assert_checkequal(a.hidden_axis_color, 4);
assert_checkequal(a.hiddencolor, 4);
assert_checkequal(a.line_mode, "on");
assert_checkequal(a.line_style, 1);
assert_checkequal(a.thickness, 1);
assert_checkequal(a.mark_mode, "off");
assert_checkequal(a.mark_style, 0);
assert_checkequal(a.mark_size_unit, "tabulated");
assert_checkequal(a.mark_size, 0);
assert_checkequal(a.mark_foreground, -1);
assert_checkequal(a.mark_background, -2);
assert_checkequal(a.foreground, -1);
assert_checkequal(a.background, -2);
assert_checkequal(a.arc_drawing_method, "lines");
assert_checkequal(a.clip_state, "clipgrf");
assert_checkequal(a.clip_box, []);
assert_checkequal(a.user_data, []);

// Check caption with strf="181"
close
x=(0.1:0.1:2*%pi)';
plot2d(x, sin(x), strf="181", leg="sinus");
f=gcf();
a=gca();
c=a.children(1); //compound
l=a.children(2); //legend
p=c.children(1); //polyline
// Check figure
assert_checkequal(f.auto_resize, "on");
assert_checkequal(f.viewport, [0,0]);
assert_checkequal(f.figure_name, gettext("Graphic window number %d"));
assert_checkequal(f.figure_id, 0);
assert_checkequal(f.pixel_drawing_mode, "copy");
assert_checkequal(f.anti_aliasing, "off");
assert_checkequal(f.immediate_drawing, "on");
assert_checkequal(f.background, -2);
assert_checkequal(f.visible, "on");
assert_checkequal(f.rotation_style, "unary");
assert_checkequal(f.event_handler, "");
assert_checkequal(f.event_handler_enable, "off");
assert_checkequal(f.user_data, []);
assert_checkequal(f.tag, "");
// Check legend
assert_checkequal(l.parent.type,"Axes");
assert_checkequal(l.visible,"on");
assert_checkequal(l.text,"sinus");
assert_checkequal(l.font_style,6);
assert_checkequal(l.font_size,1);
assert_checkequal(l.font_color,-1);
assert_checkequal(l.fractional_font,"off");
assert_checkequal(l.links.type,"Polyline");
assert_checkequal(l.legend_location,"lower_caption");
assert_checktrue(l.position - [0.125,0.9375] < 1d-7);
assert_checkequal(l.line_mode,"off");
assert_checkequal(l.thickness,1);
assert_checkequal(l.foreground,-1);
assert_checkequal(l.fill_mode,"off");
assert_checkequal(l.background,-2);
assert_checkequal(l.clip_state,"off");
assert_checkequal(l.clip_box,[]);
assert_checkequal(l.user_data,[]);

// Check frameflag=1
close
x=(0.1:0.1:2*%pi)';
plot2d(x, sin(x), frameflag=1);
f=gcf();
a=gca();
c=a.children(1); //compound
p=c.children(1); //polyline
// Check axes
assert_checkequal(a.visible, "on");
assert_checkequal(a.axes_visible, ["on" "on" "on"]);
assert_checkequal(a.axes_reverse, ["off" "off" "off"]);
assert_checkequal(a.grid, [-1 -1]);
assert_checkequal(a.grid_position, "background");
assert_checkequal(a.x_location, "bottom");
assert_checkequal(a.y_location, "left");
assert_checkequal(a.auto_ticks, ["on" "on" "on"]);
assert_checkequal(a.box, "off");
assert_checkequal(a.filled, "on");
assert_checkequal(a.sub_ticks, [1, 1]);
assert_checkequal(a.font_style, 6);
assert_checkequal(a.font_size, 1);
assert_checkequal(a.font_color, -1);
assert_checkequal(a.fractional_font, "off");
assert_checkequal(a.isoview, "off");
assert_checkequal(a.cube_scaling, "off");
assert_checkequal(a.view, "2d");
assert_checkequal(a.rotation_angles, [0, 270]);
assert_checkequal(a.log_flags, "nnn");
assert_checkequal(a.tight_limits, ["on", "on", "on"]);
assert_checkequal(a.data_bounds,[0, 0; 0, 0]);
assert_checkequal(a.zoom_box, []);
assert_checkequal(a.margins, [0.125, 0.125, 0.125, 0.125]);
assert_checkequal(a.axes_bounds, [0, 0, 1, 1]);
assert_checkequal(a.auto_clear, "off");
assert_checkequal(a.auto_scale, "on");
assert_checkequal(a.hidden_axis_color, 4);
assert_checkequal(a.hiddencolor, 4);
assert_checkequal(a.line_mode, "on");
assert_checkequal(a.line_style, 1);
assert_checkequal(a.thickness, 1);
assert_checkequal(a.mark_mode, "off");
assert_checkequal(a.mark_style, 0);
assert_checkequal(a.mark_size_unit, "tabulated");
assert_checkequal(a.mark_size, 0);
assert_checkequal(a.mark_foreground, -1);
assert_checkequal(a.mark_background, -2);
assert_checkequal(a.foreground, -1);
assert_checkequal(a.background, -2);
assert_checkequal(a.arc_drawing_method, "lines");
assert_checkequal(a.clip_state, "clipgrf");
assert_checkequal(a.clip_box, []);
assert_checkequal(a.user_data, []);
// Check compound
assert_checkequal(c.parent.type, "Axes");
assert_checkequal(c.children(:).type, "Polyline");
assert_checkequal(c.visible, "on");
assert_checkequal(c.user_data, []);
// Check polyline
DefaultData=(0.1:0.1:2*%pi)';
assert_checkequal(p.parent.type, "Compound");
assert_checkequal(p.children, []);
assert_checkequal(p.visible, "on");
assert_checkequal(p.data, [DefaultData, sin(DefaultData)]);
assert_checkequal(p.closed, "off");
assert_checkequal(p.line_mode, "on");
assert_checkequal(p.fill_mode, "off");
assert_checkequal(p.line_style, 1);
assert_checkequal(p.thickness, 1);
assert_checkequal(p.arrow_size_factor, 1);
assert_checkequal(p.polyline_style, 1);
assert_checkequal(p.foreground, 1);
assert_checkequal(p.background, -2);
assert_checkequal(p.interp_color_vector, []);
assert_checkequal(p.interp_color_mode, "off");
assert_checkequal(p.mark_mode, "off");
assert_checkequal(p.mark_style, 0);
assert_checkequal(p.mark_size_unit, "tabulated");
assert_checkequal(p.mark_size, 0);
assert_checkequal(p.mark_foreground, -1);
assert_checkequal(p.mark_background, -2);
assert_checkequal(p.x_shift, []);
assert_checkequal(p.y_shift, []);
assert_checkequal(p.z_shift, []);
assert_checkequal(p.bar_width, 0);
assert_checkequal(p.clip_state, "clipgrf");
assert_checkequal(p.clip_box, []);
assert_checkequal(p.user_data, []);
// Check frameflag=2
close
x=(0.1:0.1:2*%pi)';
plot2d(x, sin(x), frameflag=2);
f=gcf();
a=gca();
c=a.children(1); //compound
p=c.children(1); //polyline
// Check axes
assert_checkequal(a.visible, "on");
assert_checkequal(a.axes_visible, ["on" "on" "on"]);
assert_checkequal(a.axes_reverse, ["off" "off" "off"]);
assert_checkequal(a.grid, [-1 -1]);
assert_checkequal(a.grid_position, "background");
assert_checkequal(a.x_location, "bottom");
assert_checkequal(a.y_location, "left");
assert_checkequal(a.auto_ticks, ["on" "on" "on"]);
assert_checkequal(a.box, "off");
assert_checkequal(a.filled, "on");
assert_checkequal(a.sub_ticks, [0, 1]);
assert_checkequal(a.font_style, 6);
assert_checkequal(a.font_size, 1);
assert_checkequal(a.font_color, -1);
assert_checkequal(a.fractional_font, "off");
assert_checkequal(a.isoview, "off");
assert_checkequal(a.cube_scaling, "off");
assert_checkequal(a.view, "2d");
assert_checkequal(a.rotation_angles, [0, 270]);
assert_checkequal(a.log_flags, "nnn");
assert_checkequal(a.tight_limits, ["on", "on", "on"]);
assert_checktrue(a.data_bounds - [0.1, -0.9999233; 6.2, 0.9995736] < 1d-7);
assert_checkequal(a.zoom_box, []);
assert_checkequal(a.margins, [0.125, 0.125, 0.125, 0.125]);
assert_checkequal(a.axes_bounds, [0, 0, 1, 1]);
assert_checkequal(a.auto_clear, "off");
assert_checkequal(a.auto_scale, "on");
assert_checkequal(a.hidden_axis_color, 4);
assert_checkequal(a.hiddencolor, 4);
assert_checkequal(a.line_mode, "on");
assert_checkequal(a.line_style, 1);
assert_checkequal(a.thickness, 1);
assert_checkequal(a.mark_mode, "off");
assert_checkequal(a.mark_style, 0);
assert_checkequal(a.mark_size_unit, "tabulated");
assert_checkequal(a.mark_size, 0);
assert_checkequal(a.mark_foreground, -1);
assert_checkequal(a.mark_background, -2);
assert_checkequal(a.foreground, -1);
assert_checkequal(a.background, -2);
assert_checkequal(a.arc_drawing_method, "lines");
assert_checkequal(a.clip_state, "clipgrf");
assert_checkequal(a.clip_box, []);
assert_checkequal(a.user_data, []);
// Check frameflag=3
close
x=(0.1:0.1:2*%pi)';
plot2d(x, sin(x), frameflag=3);
f=gcf();
a=gca();
c=a.children(1); //compound
p=c.children(1); //polyline
// Check axes
assert_checkequal(a.visible, "on");
assert_checkequal(a.axes_visible, ["on" "on" "on"]);
assert_checkequal(a.axes_reverse, ["off" "off" "off"]);
assert_checkequal(a.grid, [-1 -1]);
assert_checkequal(a.grid_position, "background");
assert_checkequal(a.x_location, "bottom");
assert_checkequal(a.y_location, "left");
assert_checkequal(a.auto_ticks, ["on" "on" "on"]);
assert_checkequal(a.box, "off");
assert_checkequal(a.filled, "on");
assert_checkequal(a.sub_ticks, [1, 1]);
assert_checkequal(a.isoview, "on");
assert_checkequal(a.rotation_angles, [0, 270]);
assert_checkequal(a.tight_limits, ["off", "off", "off"]);
assert_checkequal(a.data_bounds, [0, 0; 0, 0]);
// Check frameflag=4
close
x=(0.1:0.1:2*%pi)';
plot2d(x, sin(x), frameflag=4);
f=gcf();
a=gca();
c=a.children(1); //compound
p=c.children(1); //polyline
// Check axes
assert_checkequal(a.visible, "on");
assert_checkequal(a.axes_visible, ["on" "on" "on"]);
assert_checkequal(a.axes_reverse, ["off" "off" "off"]);
assert_checkequal(a.grid, [-1 -1]);
assert_checkequal(a.grid_position, "background");
assert_checkequal(a.x_location, "bottom");
assert_checkequal(a.y_location, "left");
assert_checkequal(a.auto_ticks, ["on" "on" "on"]);
assert_checkequal(a.box, "off");
assert_checkequal(a.filled, "on");
assert_checkequal(a.sub_ticks, [0, 0]);
assert_checkequal(a.isoview, "on");
assert_checkequal(a.rotation_angles, [0, 270]);
assert_checkequal(a.tight_limits, ["off", "off", "off"]);
assert_checktrue(a.data_bounds - [0.1, -0.9999233; 6.2, 0.9995736] < 1d-7);
// Check frameflag=5
close
x=(0.1:0.1:2*%pi)';
plot2d(x, sin(x), frameflag=5);
f=gcf();
a=gca();
c=a.children(1); //compound
p=c.children(1); //polyline
// Check axes
assert_checkequal(a.visible, "on");
assert_checkequal(a.axes_visible, ["on" "on" "on"]);
assert_checkequal(a.axes_reverse, ["off" "off" "off"]);
assert_checkequal(a.grid, [-1 -1]);
assert_checkequal(a.grid_position, "background");
assert_checkequal(a.x_location, "bottom");
assert_checkequal(a.y_location, "left");
assert_checkequal(a.auto_ticks, ["on" "on" "on"]);
assert_checkequal(a.box, "off");
assert_checkequal(a.filled, "on");
assert_checkequal(a.sub_ticks, [1, 1]);
assert_checkequal(a.isoview, "off");
assert_checkequal(a.rotation_angles, [0, 270]);
assert_checkequal(a.tight_limits, ["off", "off", "off"]);
assert_checkequal(a.data_bounds, [0, 0; 0, 0]);
// Check frameflag=6
close
x=(0.1:0.1:2*%pi)';
plot2d(x, sin(x), frameflag=6);
f=gcf();
a=gca();
c=a.children(1); //compound
p=c.children(1); //polyline
// Check axes
assert_checkequal(a.visible, "on");
assert_checkequal(a.axes_visible, ["on" "on" "on"]);
assert_checkequal(a.axes_reverse, ["off" "off" "off"]);
assert_checkequal(a.grid, [-1 -1]);
assert_checkequal(a.grid_position, "background");
assert_checkequal(a.x_location, "bottom");
assert_checkequal(a.y_location, "left");
assert_checkequal(a.auto_ticks, ["on" "on" "on"]);
assert_checkequal(a.box, "off");
assert_checkequal(a.filled, "on");
assert_checkequal(a.sub_ticks, [0, 1]);
assert_checkequal(a.isoview, "off");
assert_checkequal(a.rotation_angles, [0, 270]);
assert_checkequal(a.tight_limits, ["off", "off", "off"]);
assert_checktrue(a.data_bounds - [0.1, -0.9999233; 6.2, 0.9995736] < 1d-7);

// Check nax
close
x=(0.1:0.1:2*%pi)';
plot2d(x, sin(x), nax=[2,10,2,10]);
f=gcf();
a=gca();
c=a.children(1); //compound
p=c.children(1); //polyline
// Check axes
assert_checkequal(a.visible, "on");
assert_checkequal(a.axes_visible, ["on" "on" "on"]);
assert_checkequal(a.axes_reverse, ["off" "off" "off"]);
assert_checkequal(a.grid, [-1 -1]);
assert_checkequal(a.grid_position, "background");
assert_checkequal(a.x_location, "bottom");
assert_checkequal(a.y_location, "left");
assert_checkequal(a.auto_ticks, ["off" "off" "on"]);
assert_checkequal(a.box, "off");
assert_checkequal(a.filled, "on");
assert_checkequal(a.sub_ticks, [2, 2]);
assert_checkequal(a.font_style, 6);
assert_checkequal(a.font_size, 1);
assert_checkequal(a.font_color, -1);
assert_checkequal(a.fractional_font, "off");
assert_checkequal(a.isoview, "off");
assert_checkequal(a.cube_scaling, "off");
assert_checkequal(a.view, "2d");
assert_checkequal(a.rotation_angles, [0, 270]);
assert_checkequal(a.log_flags, "nnn");
assert_checkequal(a.tight_limits, ["off", "off", "off"]);
assert_checktrue(a.data_bounds - [0.1, -0.9999233; 6.2, 0.9995736] < 1d-7);
assert_checkequal(a.zoom_box, []);
assert_checkequal(a.margins, [0.125, 0.125, 0.125, 0.125]);
assert_checkequal(a.axes_bounds, [0, 0, 1, 1]);
assert_checkequal(a.auto_clear, "off");
assert_checkequal(a.auto_scale, "on");
assert_checkequal(a.hidden_axis_color, 4);
assert_checkequal(a.hiddencolor, 4);
assert_checkequal(a.line_mode, "on");
assert_checkequal(a.line_style, 1);
assert_checkequal(a.thickness, 1);
assert_checkequal(a.mark_mode, "off");
assert_checkequal(a.mark_style, 0);
assert_checkequal(a.mark_size_unit, "tabulated");
assert_checkequal(a.mark_size, 0);
assert_checkequal(a.mark_foreground, -1);
assert_checkequal(a.mark_background, -2);
assert_checkequal(a.foreground, -1);
assert_checkequal(a.background, -2);
assert_checkequal(a.arc_drawing_method, "lines");
assert_checkequal(a.clip_state, "clipgrf");
assert_checkequal(a.clip_box, []);
assert_checkequal(a.user_data, []);
close
