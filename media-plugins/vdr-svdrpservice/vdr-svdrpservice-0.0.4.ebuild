# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-svdrpservice/vdr-svdrpservice-0.0.4.ebuild,v 1.4 2012/05/01 17:15:21 hd_brummy Exp $

EAPI="4"

inherit vdr-plugin-2

DESCRIPTION="VDR Plugin: offers SVDRP connections as a service to other plugins"
HOMEPAGE="http://vdr.schmirler.de/"
SRC_URI="http://vdr.schmirler.de/svdrpservice/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=media-video/vdr-1.4.0"
RDEPEND="${DEPEND}"

src_prepare() {
	vdr-plugin-2_src_prepare

	# wrong detection
	sed -i Makefile \
		-e "s:VDRDIR)/Makefile:VDRDIR)/Make.common:"
}

src_install() {
	vdr-plugin-2_src_install

	insinto /usr/include/svdrpservice
	doins svdrpservice.h
}
