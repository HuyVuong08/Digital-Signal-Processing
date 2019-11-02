// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) ????-2008 - INRIA
// Copyright (C) 2009 - DIGITEO
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// <-- ENGLISH IMPOSED -->
// <-- CLI SHELL MODE -->

ilib_verbose(0);

if getos() == 'Windows' then
  TMP_OS_DIR = getenv('TMP','err');
  if (TMP_OS_DIR == 'err') then pause,end;
else
  TMP_OS_DIR = '/tmp';
  if ~isdir(TMP_OS_DIR) then pause,end;
end

TMP_DIR = TMP_OS_DIR+filesep()+'link';

rmdir(TMP_DIR,'s');
mkdir(TMP_OS_DIR,'link');


if ~isdir(TMP_DIR) then pause,end;

//Example of the use of ilib_for_link with  a simple C code
    f1=['#include <math.h>'
    'void fooc(double c[],double a[], double *b,int *m,int *n)'
    '{'
    '   int i;'
    '   for ( i =0 ; i < (*m)*(*n) ; i++) '
    '     c[i] = sin(a[i]) + *b; '
    '}'];

mputl(f1, TMP_DIR + filesep() + 'fooc.c');

cur_dir = pwd();
chdir(TMP_DIR);

//creating the shared library: a Makefile and a loader are 
//generated, the code is compiled and a shared library built.
ilib_for_link('fooc', 'fooc.c', [], "c"); 

// load the shared library 
exec('loader.sce'); 

link('show');

// call the new linked entry point
a = linspace(0, %pi, 10);
b = 5;
y1 = call('fooc', a, 2, 'd', b, 3, 'd', size(a,1), 4, 'i', size(a,2), 5, 'i', 'out', size(a), 1, 'd');
    
// check
r = y1 - ( sin(a) + b );
if (or(abs(r - zeros(1,10))> %eps * 10)) then pause,end

// ulink() all libraries
ulink();

//remove TMP_DIR
rmdir(TMP_DIR,'s');
