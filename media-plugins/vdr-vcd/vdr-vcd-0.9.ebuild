# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-vcd/vdr-vcd-0.9.ebuild,v 1.6 2012/11/02 19:14:44 hd_brummy Exp $

inherit eutils vdr-plugin

DESCRIPTION="VDR plugin: play video cds"

HOMEPAGE="http://www.heiligenmann.de/"
SRC_URI=" http://www.heiligenmann.de/vdr/download/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND=">=media-video/vdr-1.4.7"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}_vdr-1.7.2.diff" )

src_unpack() {
	vdr-plugin_src_unpack unpack
	cd "${S}"

	# Patch Makefile, as VDRDIR is no well known variable name
	# to stop spare -I in gcc cmdline
	sed -e 's:$(VDRINC):$(VDRDIR)/include:' -i Makefile
	vdr-plugin_src_unpack all_but_unpack
}
