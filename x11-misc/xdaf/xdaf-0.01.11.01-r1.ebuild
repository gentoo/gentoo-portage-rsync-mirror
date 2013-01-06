# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdaf/xdaf-0.01.11.01-r1.ebuild,v 1.1 2010/09/17 00:57:48 jer Exp $

EAPI="2"

inherit eutils toolchain-funcs

MY_P=${P/-0/-A}

DESCRIPTION="A tool to provide visual feedback of local disks activity by changing the default X11 mouse pointer"
HOMEPAGE="http://ezix.org/project/wiki/Xdaf"
SRC_URI="mirror://sourceforge/ezix/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
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

src_prepare() {
	epatch "${FILESDIR}"/${P}-includes.patch
}

src_configure() {
	xmkmf || die
}
src_compile() {
	emake \
		CC=$(tc-getCC) \
		CCOPTIONS="${CFLAGS}" \
		EXTRA_LDOPTIONS="${LDFLAGS}" \
		|| die "emake failed"
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	newman xdaf.man xdaf.1
	dodoc README
}
