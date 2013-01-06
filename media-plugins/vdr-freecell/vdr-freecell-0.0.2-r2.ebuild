# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-freecell/vdr-freecell-0.0.2-r2.ebuild,v 1.5 2011/01/29 00:19:56 hd_brummy Exp $

EAPI="3"

inherit vdr-plugin

DESCRIPTION="VDR plugin: play 'Freecell' on the On Screen Display"
HOMEPAGE="http://www.magoa.net/linux/index.php?view=freecell"
SRC_URI="http://www.magoa.net/linux/files/${P}.tgz
		mirror://vdrfiles/${PN}/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=media-video/vdr-1.2.6"

PATCHES=("${FILESDIR}/${PN}-time_ms.diff"
		"${FILESDIR}/gcc-3.4.patch"
		"${FILESDIR}/${P}-gentoo.diff"
		"${FILESDIR}/${P}_vdr-1.5.4-compile.diff")

src_install() {
	vdr-plugin_src_install

	insopts -m0644 -ovdr -gvdr
	insinto /usr/share/vdr/freecell
	doins "${S}/${VDRPLUGIN}"/*
}
