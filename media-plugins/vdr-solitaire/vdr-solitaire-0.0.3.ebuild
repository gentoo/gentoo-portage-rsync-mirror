# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-solitaire/vdr-solitaire-0.0.3.ebuild,v 1.1 2008/04/28 08:55:14 zzam Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: Solitaire game"
HOMEPAGE="http://www.djdagobert.com/vdr/solitaire/index.html"
SRC_URI="http://www.djdagobert.com/vdr/solitaire/${P}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.3.25"

SOLITAIRE_DATA_DIR="/usr/share/vdr/solitaire"

src_unpack() {
	vdr-plugin_src_unpack

	cd "${S}"
	sed -i cards.c cursor.c \
		-e 's#cPlugin::ConfigDirectory("solitaire")#"'${SOLITAIRE_DATA_DIR}'"#'
}

src_install() {
	vdr-plugin_src_install

	insinto "${SOLITAIRE_DATA_DIR}"
	doins "${S}"/solitaire/*.xpm
}
