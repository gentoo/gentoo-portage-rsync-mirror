# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fbpager/fbpager-20090221.ebuild,v 1.3 2009/09/06 14:46:31 maekke Exp $

EAPI=2
inherit eutils

DESCRIPTION="A Pager for fluxbox"
HOMEPAGE="http://git.fluxbox.org/?p=fbpager.git"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~mips ppc ~sparc x86 ~x86-fbsd"
IUSE="+xrender"

DEPEND="x11-libs/libX11
	xrender? ( x11-libs/libXrender )"
RDEPEND="${DEPEND}"

src_configure() {
	econf $(use_enable xrender)
}

src_install() {
	einstall || die "einstall failed"
	dodoc AUTHORS NEWS README TODO
}

pkg_postinst() {
	einfo "To run fbpager inside the FluxBox slit, use fbpager -w"
}
