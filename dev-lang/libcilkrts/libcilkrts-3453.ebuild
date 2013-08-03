# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/libcilkrts/libcilkrts-3453.ebuild,v 1.1 2013/08/03 22:10:23 ottxor Exp $

EAPI=5

inherit autotools-utils

DESCRIPTION="Intel Cilk Plus run time library"
HOMEPAGE="http://cilkplus.org"
SRC_URI="http://cilkplus.org/sites/default/files/runtime_source/cilkplus-rtl-00${PV}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/cilkplus-rtl-bsd-00${PV}"

AUTOTOOLS_AUTORECONF=1

DOCS=( README )

PATCHES=( "${FILESDIR}/${PN}-2546-include.patch"  "${FILESDIR}/${PN}-2856-flags.patch" )
