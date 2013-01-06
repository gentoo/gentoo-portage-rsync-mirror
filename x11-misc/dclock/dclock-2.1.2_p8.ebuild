# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/dclock/dclock-2.1.2_p8.ebuild,v 1.4 2010/07/21 14:39:02 ssuominen Exp $

inherit eutils

DESCRIPTION="Digital clock for the X window system."
HOMEPAGE="ftp://ftp.ac-grenoble.fr/ge/Xutils/"
SRC_URI="mirror://debian/pool/main/d/${PN}/${PN}_${PV/_p*/}.orig.tar.gz
		mirror://debian/pool/main/d/${PN}/${PN}_${PV/_p/-}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXt
	x11-libs/libXext
	app-text/rman"
DEPEND="${RDEPEND}
	x11-misc/imake"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch ../${PN}_${PV/_p/-}.diff
	ln -sf dclock.1 dclock.man # needed to fix xmkmf breakage
}

src_compile() {
	xmkmf || die
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	emake DESTDIR="${D}" install.man || die
	insinto /usr/share/sounds
	doins sounds/* || die
	insinto /usr/share/X11/app-defaults
	newins Dclock.ad DClock || die
	dodoc README TODO
}
