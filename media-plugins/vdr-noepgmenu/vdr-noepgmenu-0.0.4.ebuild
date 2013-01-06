# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-noepgmenu/vdr-noepgmenu-0.0.4.ebuild,v 1.3 2008/04/28 08:38:06 zzam Exp $

inherit vdr-plugin

IUSE=""
SLOT="0"

DESCRIPTION="VDR Plugin: Configure the noepg patch"
HOMEPAGE="http://winni.vdr-developer.org/noepgmenu/downloads/"
SRC_URI="http://winni.vdr-developer.org/noepgmenu/downloads/${P}.tgz
	mirror://gentoo/${P}-unlimit-wareagle2.diff.bz2"

LICENSE="GPL-2"
DEPEND=">=media-video/vdr-1.4.7-r8"
RDEPEND="${DEPEND}"

KEYWORDS="~amd64 ~x86"
PATCHES=("${WORKDIR}/${P}-unlimit-wareagle2.diff")

pkg_setup() {
	vdr-plugin_pkg_setup

	local header="${VDR_INCLUDE_DIR}/config.h"
	ebegin "Checking for patched VDR"
	grep -q 'char \*noEPGList' "${header}"
	eend $? "You need to recompile VDR with USE=noepg" \
		|| die "VDR not compiled with new noepg-patch"
}
