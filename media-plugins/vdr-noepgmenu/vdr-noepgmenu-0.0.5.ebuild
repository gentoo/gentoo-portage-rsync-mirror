# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-noepgmenu/vdr-noepgmenu-0.0.5.ebuild,v 1.4 2014/02/23 20:27:35 hd_brummy Exp $

EAPI=5

inherit vdr-plugin-2

DESCRIPTION="VDR Plugin: Configure the noepg patch"
HOMEPAGE="http://winni.vdr-developer.org/noepgmenu/"
SRC_URI="http://winni.vdr-developer.org/noepgmenu/downloads/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=media-video/vdr-1.4.7-r8[noepg]
		<media-video/vdr-1.7.25"
RDEPEND="${DEPEND}"

KEYWORDS="~amd64 x86"
