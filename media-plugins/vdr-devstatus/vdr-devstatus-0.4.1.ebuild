# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-devstatus/vdr-devstatus-0.4.1.ebuild,v 1.3 2012/07/05 19:52:56 hd_brummy Exp $

EAPI="4"

inherit vdr-plugin-2

DESCRIPTION="VDR plugin: displays the usage status of the available devices."
HOMEPAGE="http://www.u32.de/vdr.html"
SRC_URI="http://www.u32.de/download/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0"
RDEPEND="${DEPEND}"

src_prepare() {
	vdr-plugin-2_src_prepare

	if has_version ">=media-video/vdr-1.7.28"; then
		sed -i "s:SetRecording(\([^,]*\),[^)]*)):SetRecording(\1\):" devstatus.c
	fi
}
