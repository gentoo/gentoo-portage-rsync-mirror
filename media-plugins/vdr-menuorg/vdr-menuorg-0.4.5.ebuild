# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-menuorg/vdr-menuorg-0.4.5.ebuild,v 1.3 2014/02/23 20:18:52 hd_brummy Exp $

EAPI=5

inherit vdr-plugin-2

DESCRIPTION="VDR plugin: make osd menu configurable via config-file"
HOMEPAGE="http://www.e-tobi.net/blog/pages/vdr-menuorg/"
SRC_URI="mirror://vdr-developerorg/879/${P}.tar.gz"
#SRC_URI="http://www.e-tobi.net/blog/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.5.18[menuorg]
	dev-cpp/libxmlpp:2.6
	dev-cpp/glibmm"
RDEPEND="${DEPEND}"

src_install() {
	vdr-plugin-2_src_install

	insinto /etc/vdr/plugins/menuorg
	doins menuorg.xml
}
