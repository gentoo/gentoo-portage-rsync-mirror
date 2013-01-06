# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdaf/xdaf-0.01.11.01.ebuild,v 1.9 2010/07/22 11:32:06 ssuominen Exp $

MY_P=${P/-0/-A}

DESCRIPTION="A tool to provide visual feedback of local disks activity by changing the default X11 mouse pointer"
HOMEPAGE="http://ezix.sourceforge.net/software/xdaf.html"
SRC_URI="mirror://sourceforge/ezix/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXmu
	x11-libs/libXt
	x11-libs/libXaw
	x11-libs/libXext
	x11-libs/libXpm
	x11-libs/libXp"
DEPEND="${RDEPEND}
	x11-misc/imake"

S=${WORKDIR}/${MY_P}

src_compile() {
	xmkmf || die
	emake CDEBUGFLAGS="${CFLAGS}" || die "emake failed"
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	newman xdaf.man xdaf.1
	dodoc README
}
