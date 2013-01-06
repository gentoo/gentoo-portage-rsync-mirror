# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-bitstreamout/vdr-bitstreamout-0.89c.ebuild,v 1.4 2011/12/14 16:50:40 ago Exp $

EAPI="3"

IUSE=""

inherit vdr-plugin

DESCRIPTION="VDR Plugin: play ac3 sound over SPDIF-port of an alsa-compatible soundcard"
HOMEPAGE="http://bitstreamout.sourceforge.net"
SRC_URI="mirror://sourceforge/bitstreamout/${P}.tar.bz2"
KEYWORDS="amd64 x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=media-video/vdr-1.2.6
	>=media-libs/alsa-lib-0.9.8
	>=media-sound/alsa-utils-0.9.8
	>=media-libs/libmad-0.14.2b-r2
	"

src_install() {
	vdr-plugin_src_install

	doman vdr-bitstreamout.5
	dodoc ChangeLog Description PROBLEMS
	dodoc "${S}"/doc/*

	cd "${S}"/mute
	dodoc README*

	insinto /usr/share/vdr/bitstreamout
	insopts -m0755

	for f in *.sh; do
		newins ${f} mute_${f}
	done
}
