# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/ed2k_hash/ed2k_hash-0.4.0-r1.ebuild,v 1.9 2011/03/20 20:04:10 jlec Exp $

EAPI="1"
inherit flag-o-matic eutils

DESCRIPTION="Tool for generating eDonkey2000 links"
HOMEPAGE="http://ed2k-tools.sourceforge.net/ed2k_hash.shtml"
RESTRICT="mirror"
SRC_URI="mirror://sourceforge/ed2k-tools/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE="fltk"
DEPEND="fltk? ( x11-libs/fltk:1 )"

src_unpack() {
	unpack ${P}.tar.gz
	epatch "${FILESDIR}/ed2k_64bit.patch"
}

src_compile() {
	if use fltk; then
		append-ldflags "$(fltk-config --ldflags)"
		export CPPFLAGS="$(fltk-config --cxxflags)"
	else
		export ac_cv_lib_fltk_main='no'
	fi

	econf --disable-dependency-tracking
	emake
}

src_install() {
	make install DESTDIR="${D}" mydocdir=/usr/share/doc/${PF}/html || die

	dodoc AUTHORS INSTALL README TODO
}
