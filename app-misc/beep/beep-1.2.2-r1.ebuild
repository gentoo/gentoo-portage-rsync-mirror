# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/beep/beep-1.2.2-r1.ebuild,v 1.12 2009/03/28 05:39:33 solar Exp $

inherit eutils base toolchain-funcs

DESCRIPTION="The advanced PC speaker beeper"
HOMEPAGE="http://www.johnath.com/beep/"
SRC_URI="mirror://gentoo/${P}.tar.gz http://www.johnath.com/beep/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ppc ppc64 sparc x86"
IUSE=""

PATCHES=( ${FILESDIR}/${P}-{Makefile,nosuid}.patch )

pkg_setup() {
	tc-export CC
}

src_install() {
	dobin beep
	fperms 0711 /usr/bin/beep
	doman beep.1.gz
	dodoc CHANGELOG CREDITS README
}
