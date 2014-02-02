# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/macchanger/macchanger-1.5.0-r2.ebuild,v 1.5 2014/02/02 20:03:42 robbat2 Exp $

DESCRIPTION="Utility for viewing/manipulating the MAC address of network interfaces"
OUI_DATE="20091029" # Generated with tools/IEEE_OUI.py in the source
OUI_FILE="OUI.list-${OUI_DATE}"
HOMEPAGE="https://github.com/alobbs/macchanger"
SRC_URI="mirror://gnu/macchanger/${P}.tar.gz
		 mirror://gentoo/${OUI_FILE}.gz"
LICENSE="GPL-2"
KEYWORDS="amd64 ~arm ppc sparc x86"
IUSE=""
SLOT="0"

DEPEND=""

src_unpack() {
	unpack ${P}.tar.gz
	zcat "${DISTDIR}"/${OUI_FILE}.gz >"${S}"/data/OUI.list || die "Failed to update OUI list"
}

src_compile() {
	# Shared data is installed below /lib, see Bug #57046
	econf \
		--bindir=/sbin \
		--datadir=/lib \
		|| die "configure failed"
	emake || die "build failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"

	dodoc AUTHORS ChangeLog NEWS README

	dodir /usr/bin
	dosym /sbin/macchanger /usr/bin/macchanger
	dosym /lib/macchanger /usr/share/macchanger
}
