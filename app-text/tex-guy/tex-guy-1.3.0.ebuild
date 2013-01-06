# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tex-guy/tex-guy-1.3.0.ebuild,v 1.4 2007/04/27 04:00:56 josejx Exp $

inherit libtool

MY_P="TeX-Guy-${PV}"
DESCRIPTION="Miscellaneous utilities using DVIlib"
HOMEPAGE="http://typehack.aial.hiroshima-u.ac.jp/TeX-Guy/"
SRC_URI="ftp://ftp.se.hiroshima-u.ac.jp/pub/TypeHack/${MY_P}.tar.gz"

KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
LICENSE="LGPL-2.1"
IUSE=""

DEPEND=">=media-libs/vflib-3.6
	=x11-libs/gtk+-1.2*"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}

	cd ${S}
	elibtoolize
}

src_compile() {
	econf || die "econf failed"
	emake -j1 CDEBUGFLAGS="${CFLAGS}" \
		CXXDEBUGFLAGS="${CXXFLAGS}" || die
}

src_install() {
	einstall localedir=${D}/usr/share/locale || die "install failed"

	dodoc 00_* CHANGES
}
