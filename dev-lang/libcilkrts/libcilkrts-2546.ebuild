# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/libcilkrts/libcilkrts-2546.ebuild,v 1.1 2012/07/18 02:23:48 ottxor Exp $

EAPI=4

inherit autotools-utils

DESCRIPTION="Intel Cilk Plus run time library"
HOMEPAGE="http://software.intel.com/en-us/articles/intel-cilk-plus/"
SRC_URI="http://software.intel.com/file/44474 -> cilkplus-rtl-00${PV}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE="static-libs"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

AUTOTOOLS_AUTORECONF=1

DOCS=( README )

PATCHES=( "${FILESDIR}/${P}-build.patch" "${FILESDIR}/${P}-include.patch" )
