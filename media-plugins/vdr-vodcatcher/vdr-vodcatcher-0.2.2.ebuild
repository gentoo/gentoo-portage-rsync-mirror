# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-vodcatcher/vdr-vodcatcher-0.2.2.ebuild,v 1.3 2012/05/01 12:30:14 hd_brummy Exp $

EAPI="4"

inherit vdr-plugin-2

DESCRIPTION="VDR plugin: Downloads rss-feeds and passes video enclosures to the mplayer plugin"
HOMEPAGE="http://projects.vdr-developer.org/projects/plg-vodcatcher"
SRC_URI="mirror://vdr-developerorg/154/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-misc/curl
		>=dev-libs/tinyxml-2.6.1
		media-video/vdr"
RDEPEND="${DEPEND}
		|| ( media-plugins/vdr-mplayer media-plugins/vdr-xineliboutput )"

PATCHES=( "${FILESDIR}/${P}_unbundle-tinyxml2.diff" )

src_prepare() {
	vdr-plugin-2_src_prepare

	sed -e "s:ConfigDirectory():ConfigDirectory( \"vodcatcher\" ):" -i src/VodcatcherPlugin.cc
}

src_install() {
	vdr-plugin-2_src_install

	insinto /etc/vdr/plugins/vodcatcher/
	doins   examples/vodcatchersources.conf

	diropts -gvdr -ovdr
	keepdir /var/cache/vdr-plugin-vodcatcher
}

pkg_postinst() {
	vdr-plugin-2_pkg_postinst

	echo
	elog "! IMPORTEND"
	elog "In order to allow the MPlayer plug-in to play back the streams passed in by the"
	elog "Vodcatcher, you must add the following entry to the mplayersources.conf file:"
	echo
	elog "/tmp;Vodcatcher;0"
	echo
}
