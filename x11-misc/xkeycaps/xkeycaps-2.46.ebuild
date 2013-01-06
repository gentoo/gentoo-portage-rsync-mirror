# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xkeycaps/xkeycaps-2.46.ebuild,v 1.23 2012/12/23 20:23:24 ulm Exp $

inherit eutils

DESCRIPTION="GUI frontend to xmodmap"
SRC_URI="http://www.jwz.org/${PN}/${P}.tar.Z"
HOMEPAGE="http://www.jwz.org/xkeycaps/"

LICENSE="HPND"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

RDEPEND="x11-misc/xbitmaps
	x11-libs/libX11
	x11-libs/libXmu
	x11-libs/libXt
	x11-libs/libXaw
	x11-libs/libXext"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-misc/imake
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/Imakefile.patch"
}

src_compile() {
	xmkmf || die
	sed -i \
		-e "s,all:: xkeycaps.\$(MANSUFFIX).html,all:: ,g" \
		Makefile || \
			die "sed Makefile failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README *.txt        || die "dodoc failed"
}
