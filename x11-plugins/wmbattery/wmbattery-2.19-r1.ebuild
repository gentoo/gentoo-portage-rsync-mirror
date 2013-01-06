# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmbattery/wmbattery-2.19-r1.ebuild,v 1.8 2012/07/08 15:24:35 jer Exp $

inherit eutils

IUSE=""

S=${WORKDIR}/${PN}

DESCRIPTION="A dockable app to report APM battery stats."
SRC_URI="http://kitenet.net/programs/wmbattery/${P/-/_}.tar.gz"
HOMEPAGE="http://joeyh.name/code/wmbattery/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 -sparc ~ppc"

RDEPEND="sys-apps/apmd
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXt
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xextproto"

src_compile() {
	econf || die "Configuration failed"
	emake icondir="/usr/share/pixmaps/wmbattery" || die "Compilation failed"
}

src_install () {
	dobin wmbattery
	dodoc README TODO

	mv wmbattery.1x wmbattery.1
	doman wmbattery.1

	insinto /usr/share/pixmaps/wmbattery
	doins *.xpm
}
