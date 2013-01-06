# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbrun/bbrun-1.6.ebuild,v 1.11 2012/05/05 04:53:48 jdhore Exp $

EAPI=3
inherit eutils multilib toolchain-funcs

DESCRIPTION="blackbox program execution dialog box"
HOMEPAGE="http://www.darkops.net/bbrun"
SRC_URI="http://www.darkops.net/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	x11-libs/libXpm
	virtual/pkgconfig"

S=${WORKDIR}/${P}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${P}-respectflags.patch
}

src_compile() {
	emake CC="$(tc-getCC)" \
		LIBDIR="-L/usr/$(get_libdir)" || die "emake failed."
}

src_install () {
	dobin ${PN} || die
	dodoc ../{Changelog,README} || die
}
