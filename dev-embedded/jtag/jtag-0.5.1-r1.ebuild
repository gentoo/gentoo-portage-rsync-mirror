# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/jtag/jtag-0.5.1-r1.ebuild,v 1.6 2013/02/05 23:23:15 vapier Exp $

EAPI="4"

inherit eutils

DESCRIPTION="software package for working with JTAG-aware (IEEE 1149.1) hardware devices (parts) and boards through JTAG adapter"
HOMEPAGE="http://openwince.sourceforge.net/jtag/"
SRC_URI="mirror://sourceforge/openwince/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ~ppc"
IUSE=""

DEPEND="dev-embedded/include"
RDEPEND="${DEPEND}
	!dev-embedded/urjtag"

src_prepare() {
	epatch "${FILESDIR}"/${P}-no-erase-overshoot.diff
}
