# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-sysinfo/vdr-sysinfo-0.1.0a-r1.ebuild,v 1.4 2007/07/03 22:08:26 hd_brummy Exp $

inherit vdr-plugin eutils

DESCRIPTION="VDR plugin: Shows information over your system (CPU/Memory usage ...)"
HOMEPAGE="http://kikko77.altervista.org/"
SRC_URI="http://kikko77.altervista.org/sections/Download/[12]_sysinfo/${P}.tgz
		mirror://gentoo/${P}-firefly-20060520.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND=">=media-video/vdr-1.3.7"

RDEPEND="sys-apps/lm_sensors"

PATCHES="${DISTDIR}/${P}-firefly-20060520.tar.bz2
		${FILESDIR}/${P}-gentoo.diff
		${FILESDIR}/${P}-gcc4.diff
		${FILESDIR}/${P}_vdr-1.5.3-gentoo.diff"

VDR_CONFD_FILE="${FILESDIR}/confd-${PV}"

src_install() {
	vdr-plugin_src_install
	insinto /usr/share/vdr/sysinfo/
	insopts -m0755
	doins script/sysinfo.sh
}
