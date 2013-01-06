# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libebt/libebt-1.3.0.ebuild,v 1.17 2008/05/12 01:17:49 halcy0n Exp $

inherit autotools eutils

DESCRIPTION="A pure C++ template library that provides a clean way of getting human-readable backtrace messages"
HOMEPAGE="http://libebt.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ~ia64 ~mips ppc ~ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="doc test"

DEPEND="doc? ( app-doc/doxygen )
	test? ( dev-libs/boost )"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-as-needed.patch"
	AT_M4DIR=m4
	eautoreconf
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
	use doc && { emake doxygen || die "failed to build API docs" ; }
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog README
	use doc && dohtml -r doc/html/*
}
