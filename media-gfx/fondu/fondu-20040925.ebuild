# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fondu/fondu-20040925.ebuild,v 1.3 2009/09/23 15:08:59 ssuominen Exp $

DESCRIPTION="Utilities for converting between and manipulating mac fonts and unix fonts"
HOMEPAGE="http://fondu.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_src-${PV:2:6}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

S=${WORKDIR}/${PN}

src_install() {
	dodir /usr/bin
	einstall || die "make install failed"
	dodoc README
}
