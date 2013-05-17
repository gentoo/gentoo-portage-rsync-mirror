# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gvim/gvim-9999.ebuild,v 1.1 2013/05/17 00:44:17 radhermit Exp $

EAPI=5
VIM_VERSION="7.3"
PYTHON_COMPAT=( python{2_5,2_6,2_7,3_1,3_2,3_3} )
inherit vim

GVIMRC_FILE_SUFFIX="-r1"
GVIM_DESKTOP_SUFFIX="-r2"

DESCRIPTION="GUI version of the Vim text editor"
