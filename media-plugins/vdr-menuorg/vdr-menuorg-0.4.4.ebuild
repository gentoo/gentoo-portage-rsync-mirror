# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-menuorg/vdr-menuorg-0.4.4.ebuild,v 1.3 2009/12/23 20:56:20 hd_brummy Exp $

EAPI="2"

inherit vdr-plugin

DESCRIPTION="VDR plugin: make osd menu configurable via config-file"
HOMEPAGE="http://www.e-tobi.net/blog/pages/vdr-menuorg/"
SRC_URI="http://www.e-tobi.net/blog/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.5.18[menuorg]
	dev-cpp/libxmlpp:2.6
	dev-cpp/glibmm"
RDEPEND="${DEPEND}"

src_install() {
	vdr-plugin_src_install

	insinto /etc/vdr/plugins/menuorg
	doins menuorg.xml
}
