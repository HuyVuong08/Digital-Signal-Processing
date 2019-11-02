/*
 * Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) INRIA
 *
 * Copyright (C) 2012 - 2016 - Scilab Enterprises
 *
 * This file is hereby licensed under the terms of the GNU GPL v2.0,
 * pursuant to article 5.3.4 of the CeCILL v.2.1.
 * This file was originally licensed under the terms of the CeCILL v2.1,
 * and continues to be available under such terms.
 * For more information, see the COPYING file which you should have received
 * along with this program.
 *
 */
#ifndef SCI_VERSION_H
#define SCI_VERSION_H

#define SCI_VERSION_MAJOR 6
#define SCI_VERSION_MINOR 0
#define SCI_VERSION_MAINTENANCE 1
#define SCI_VERSION_STRING "scilab-6.0.2"
#define SCI_VERSION_WIDE_STRING L"scilab-6.0.2"
/* SCI_VERSION_REVISION --> hash key commit */
#define SCI_VERSION_SVN_URL "svn://svn.scilab.org/scilab/trunk/"/
#define SCI_VERSION_GIT_URL "git://git.scilab.org/scilab/"
#define SCI_VERSION_REVISION origin/6.0
#define SCI_VERSION_TIMESTAMP 1550134035

void disp_scilab_version(void);

/* for compatibility */
/* Deprecated */
#define SCI_VERSION SCI_VERSION_STRING
#define DEFAULT_SCI_VERSION_MESSAGE L"scilab-branch-6.0"

#endif
/*--------------------------------------------------------------------------*/

