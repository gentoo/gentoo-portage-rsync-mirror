# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmcalendar/wmcalendar-0.5.2.ebuild,v 1.7 2012/05/05 05:12:02 jdhore Exp $

EAPI="1"

inherit eutils toolchain-funcs

DESCRIPTION="a calendar dockapp"
HOMEPAGE="http://wmcalendar.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc sparc x86"
IUSE=""

RDEPEND="dev-libs/libical
	x11-libs/gtk+:2
	x11-libs/libXpm
	x11-libs/libXext
	x11-libs/libX11"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${P}/Src

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-exit-sin-and-cos.patch
	epatch "${FILESDIR}"/${P}-rename_kill_func.patch
}

src_compile() {
	tc-export CC
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc ../{BUGS,CHANGES,HINTS,README,TODO}
}
