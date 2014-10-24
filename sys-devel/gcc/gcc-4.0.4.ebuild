# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/gcc-4.0.4.ebuild,v 1.19 2014/10/23 23:48:17 vapier Exp $

EAPI="2"

PATCH_VER="1.2"
UCLIBC_VER="1.0"

inherit toolchain

LICENSE="GPL-2+ LGPL-2.1+ FDL-1.2+"
KEYWORDS=""

RDEPEND=""
DEPEND="${RDEPEND}
	>=${CATEGORY}/binutils-2.15.94"
