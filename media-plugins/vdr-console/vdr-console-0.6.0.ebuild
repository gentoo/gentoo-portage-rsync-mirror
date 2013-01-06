# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-console/vdr-console-0.6.0.ebuild,v 1.6 2011/01/28 18:20:46 hd_brummy Exp $

EAPI="3"

inherit vdr-plugin eutils

IUSE=""
SLOT="0"

DESCRIPTION="vdr Plugin: Shows linux console on vdr's output device"
HOMEPAGE="http://ricomp.de/vdr/"
SRC_URI="http://ricomp.de/vdr/${P}.tgz"
LICENSE="GPL-2"

KEYWORDS="~x86 ~amd64"

DEPEND=">=media-video/vdr-1.6.0"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}"/${P}-vdr-1.3.18.diff
	"${FILESDIR}"/${P}-uint64.diff )

src_prepare() {
	vdr-plugin_src_prepare

	ewarn "plugin will not support the new fonthandling"
	epatch "${FILESDIR}/${P}-vdr-1.6.x-compilefix.diff"
}
