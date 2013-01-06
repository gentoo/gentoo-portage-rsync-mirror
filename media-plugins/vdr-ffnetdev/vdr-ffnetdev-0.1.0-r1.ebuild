# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-ffnetdev/vdr-ffnetdev-0.1.0-r1.ebuild,v 1.4 2011/10/07 18:33:14 hd_brummy Exp $

EAPI="3"

inherit vdr-plugin eutils

DESCRIPTION="VDR Plugin: Output device which offers OSD via VNC and Video as raw mpeg over network"
HOMEPAGE="http://projects.vdr-developer.org/projects/plg-ffnetdev"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}/${P}

DEPEND=">=media-video/vdr-1.6.0"
RDEPEND="${DEPEND}"

src_prepare() {
	vdr-plugin_src_prepare

	epatch "${FILESDIR}/${P}-uint64.diff"
	epatch "${FILESDIR}/${P}-gcc4.3.patch"

	if grep -q "virtual cString Active" /usr/include/vdr/plugin.h; then
		epatch "${FILESDIR}/${P}-bigpatch-headers.diff"
	fi

		epatch "${FILESDIR}/${P}-vdr-1.6.0.diff"
		epatch "${FILESDIR}/${P}-buffer-overflow.diff"
}
