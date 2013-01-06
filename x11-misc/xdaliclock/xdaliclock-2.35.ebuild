# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdaliclock/xdaliclock-2.35.ebuild,v 1.6 2011/07/15 08:12:19 xarthisius Exp $

DESCRIPTION="Dali Clock is a digital clock. When a digit changes, it melts into its new shape."
HOMEPAGE="http://www.jwz.org/xdaliclock"
SRC_URI="http://www.jwz.org/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXt
	x11-libs/libXext"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	x11-proto/xproto"

S=${WORKDIR}/${P}/X11

src_install() {
	dobin ${PN} || die
	newman ${PN}.man ${PN}.1 || die
	dodoc ../README || die
}
