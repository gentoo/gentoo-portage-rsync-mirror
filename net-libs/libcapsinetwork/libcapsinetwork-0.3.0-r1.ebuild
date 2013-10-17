# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libcapsinetwork/libcapsinetwork-0.3.0-r1.ebuild,v 1.2 2013/10/17 07:22:10 pinkbyte Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=1
inherit autotools-utils flag-o-matic

DESCRIPTION="C++ network library to allow fast development of server daemon processes"
HOMEPAGE="http://unixcode.org/libcapsinetwork"
SRC_URI="http://unixcode.org/downloads/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~arm ~mips ~ppc ~sparc x86 ~amd64-linux ~x86-linux"

IUSE="static-libs"

DOCS=( AUTHORS ChangeLog NEWS README TODO )
PATCHES=(
	"${FILESDIR}/${P}-gcc43.patch"
	"${FILESDIR}/${P}-parallel.patch"
	"${FILESDIR}/${P}-64bit.patch"
)

src_prepare() {
	filter-flags -fomit-frame-pointer

	rm missing || die
	autotools-utils_src_prepare
}
