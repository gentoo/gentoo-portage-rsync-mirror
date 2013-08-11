# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/clang/clang-9999-r100.ebuild,v 1.3 2013/08/11 00:46:34 floppym Exp $

EAPI=5

inherit multilib-build

DESCRIPTION="C language family frontend for LLVM (meta-ebuild)"
HOMEPAGE="http://clang.llvm.org/"
SRC_URI=""

LICENSE="UoI-NCSA"
SLOT="0"
KEYWORDS=""
IUSE="debug multitarget python +static-analyzer"

RDEPEND="~sys-devel/llvm-${PV}[clang(-),debug=,multitarget?,python?,static-analyzer,${MULTILIB_USEDEP}]"

# Please keep this package around since it's quite likely that we'll
# return to separate LLVM & clang ebuilds when the cmake build system
# is complete.
