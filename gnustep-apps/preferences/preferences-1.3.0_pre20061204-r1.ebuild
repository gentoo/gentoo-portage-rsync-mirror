# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/preferences/preferences-1.3.0_pre20061204-r1.ebuild,v 1.6 2011/08/13 07:37:52 xarthisius Exp $

inherit gnustep-2

S=${WORKDIR}/${PN/p/P}

DESCRIPTION="Preferences is the GNUstep program with which you define your own personal user experience."
HOMEPAGE="http://www.nongnu.org/backbone/apps.html"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 x86"
SLOT="0"

DEPEND="~gnustep-libs/prefsmodule-1.1.1${PV/*_/_}"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/Preferences-nocreate-extra-dirs.patch
	epatch "${FILESDIR}"/${PN}-gnustep-make2.patch
}

src_install() {
#	egnustep_env
	dodir ${GNUSTEP_SYSTEM_LIBRARY}/Colors
	gnustep-base_src_install
}
