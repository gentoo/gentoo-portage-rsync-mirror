# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-radio/vdr-radio-0.2.4.ebuild,v 1.4 2009/08/08 19:50:34 ssuominen Exp $

inherit vdr-plugin eutils

DESCRIPTION="VDR plugin: show background image for radio and decode RDS Text"
HOMEPAGE="http://www.vdr-portal.de/board/thread.php?threadid=58795"
SRC_URI="http://www.egal-vdr.de/plugins/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND=">=media-video/vdr-1.3.43"
DEPEND="${RDEPEND}"

VDR_RCADDON_FILE="${FILESDIR}/rc-addon.sh-0.2.0"

src_unpack() {
	vdr-plugin_src_unpack
	epatch "${FILESDIR}"/${P}-glibc-2.10.patch
}

src_install() {
	vdr-plugin_src_install

	cd "${S}"/config

	insinto /usr/share/vdr/radio
	doins mpegstill/rtext*
	dosym rtextOben-kleo2-live.mpg /usr/share/vdr/radio/radio.mpg
	dosym rtextOben-kleo2-replay.mpg /usr/share/vdr/radio/replay.mpg

	exeinto /usr/share/vdr/radio
	doexe scripts/radioinfo*

	diropts -m 755 -o vdr -g vdr
	keepdir "/var/cache/vdr-radio"
}
