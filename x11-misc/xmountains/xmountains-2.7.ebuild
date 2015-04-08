# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xmountains/xmountains-2.7.ebuild,v 1.13 2012/11/17 10:23:59 ulm Exp $

MY_P=${P/-/_}

DESCRIPTION="Fractal terrains of snow-capped mountains near water"
HOMEPAGE="http://www.epcc.ed.ac.uk/~spb/xmountains/"
SRC_URI="http://www.epcc.ed.ac.uk/~spb/${PN}/${MY_P}.tar.gz"

LICENSE="HPND"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-misc/xbitmaps
	x11-libs/libX11"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-misc/imake"

S=${WORKDIR}

src_compile() {
	xmkmf || die
	emake CCOPTIONS="${CFLAGS}" || die "emake failed"
}

src_install() {
	make \
		DESTDIR="${D}" \
		BINDIR="/usr/bin" \
		install || die "install failed"
	dodoc README
	newman xmountains.man xmountains.1
}
