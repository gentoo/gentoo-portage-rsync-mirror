# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-fritzbox/vdr-fritzbox-1.5.2.ebuild,v 1.1 2013/01/06 12:05:37 hd_brummy Exp $

EAPI="5"

inherit vdr-plugin-2

DESCRIPTION="VDR Plugin: Inform about incoming phone-calls and use the fritz!box phonebook from vdr menu."
HOMEPAGE="http://www.joachim-wilke.de/show.htm?alias=vdr-fritz"
SRC_URI="http://joachim-wilke.de/vdr-fritz/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0
		dev-libs/libgcrypt
		dev-cpp/commoncpp2"
RDEPEND="${DEPEND}"

src_prepare() {
	# use the makefile, to get vdr-1.6 support
	mv "${S}"/Makefile.pre.1.7.34 "${S}"/Makefile

	vdr-plugin-2_src_prepare
}

pkg_postinst() {
	echo
	elog "It is recommend to update your firmware release to the latest."
	echo
	elog "The integrated call monitor (available in Fritz!Box official"
	elog "firmware releases >= *.04.29) has to be enabled in order to"
	elog "have the vdr-fritzbox plugin display anything on your tv. To"
	elog "enable it call #96*5* from your telephone. If that doesn't"
	elog "work for you, read the documentation for further instructions."
	echo
}
