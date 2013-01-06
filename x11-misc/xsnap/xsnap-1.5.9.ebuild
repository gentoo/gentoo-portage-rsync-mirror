# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xsnap/xsnap-1.5.9.ebuild,v 1.3 2012/12/10 21:03:47 hasufell Exp $

EAPI=4
inherit eutils toolchain-funcs

DESCRIPTION="Program to interactively take a 'snapshot' of a region of the screen"
HOMEPAGE="ftp://ftp.ac-grenoble.fr/ge/Xutils/"
SRC_URI="ftp://ftp.ac-grenoble.fr/ge/Xutils/${P}.tar.bz2"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

COMMON_DEPEND="
	media-libs/libpng
	virtual/jpeg
	x11-libs/libX11
	x11-libs/libXft
	x11-libs/libXpm
"
RDEPEND="${COMMON_DEPEND}
	media-fonts/font-misc-misc"
DEPEND="${COMMON_DEPEND}
	x11-proto/xproto
	app-text/rman
	x11-misc/imake"

src_prepare() {
	xmkmf || die
	sed -i \
		-e '/ CC = /d' \
		-e '/ LD = /d' \
		-e '/ CDEBUGFLAGS = /d' \
		-e '/ CCOPTIONS = /d' \
		-e 's|CPP = cpp|CPP = $(CC)|g' \
		Makefile || die
}

src_compile() {
	tc-export CC
	emake CCOPTIONS="${CFLAGS}" EXTRA_LDOPTIONS="${LDFLAGS}"
}

src_install() {
	emake DESTDIR="${D}" install install.man
	dodoc README AUTHORS
}
