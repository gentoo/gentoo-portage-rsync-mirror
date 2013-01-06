# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/flam3/flam3-9999.ebuild,v 1.2 2011/02/26 17:10:21 signals Exp $

EAPI=2

inherit autotools subversion

DESCRIPTION="Tools and a library for creating fractal flames"
HOMEPAGE="http://flam3.com/"
SRC_URI=""
ESVN_REPO_URI="http://flam3.googlecode.com/svn/trunk/src/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-libs/libxml2
	virtual/jpeg
	media-libs/libpng
	!<=x11-misc/electricsheep-2.6.8-r2"
RDEPEND="${DEPEND}"

src_prepare() {
	mkdir m4
	eautoreconf
}

src_configure() {
	econf --enable-shared
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc README.txt *.flam3 || die "dodoc failed"
}
