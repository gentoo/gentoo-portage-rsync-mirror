# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-fritzbox/vdr-fritzbox-1.4.1.ebuild,v 1.2 2012/02/07 01:00:41 hd_brummy Exp $

EAPI="3"

inherit vdr-plugin

DESCRIPTION="VDR Plugin: Inform about incoming phone-calls and use the fritz!box phonebook from vdr menu."
HOMEPAGE="http://www.joachim-wilke.de/show.htm?alias=vdr-fritz"
SRC_URI="http://joachim-wilke.de/vdr-fritz/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=media-video/vdr-1.4.6
		dev-libs/libgcrypt
		dev-cpp/commoncpp2"
RDEPEND="${DEPEND}"

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
