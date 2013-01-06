# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fbpager/fbpager-0.1.4.ebuild,v 1.12 2008/07/20 21:09:05 loki_val Exp $

inherit eutils

DESCRIPTION="A Pager for fluxbox"
HOMEPAGE="http://fluxbox.sourceforge.net/fbpager"
SRC_URI="http://fluxbox.org/download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~mips ppc ~sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="x11-libs/libXrender
	x11-libs/libSM
	x11-libs/libXt"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gcc41.patch"
	epatch "${FILESDIR}/${P}-gcc43.patch"
}

src_install() {
	einstall || die "einstall failed"
	dodoc AUTHORS NEWS README TODO
}

pkg_postinst() {
	einfo
	einfo "To run fbpager inside the FluxBox slit, use fbpager -w"
	einfo
}
