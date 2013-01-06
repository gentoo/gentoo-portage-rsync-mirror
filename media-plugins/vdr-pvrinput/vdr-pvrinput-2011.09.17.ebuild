# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-pvrinput/vdr-pvrinput-2011.09.17.ebuild,v 1.5 2012/05/23 15:04:33 hd_brummy Exp $

EAPI="4"

inherit vdr-plugin-2 versionator

#VERSION="668" # every bump, new version!

#MY_PV=$(replace_all_version_separators '-')
#MY_P="${PN}-${MY_PV}"

DESCRIPTION="VDR Plugin: Use a PVR* card as input device"
HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-pvrinput"
SRC_URI="mirror://gentoo/vdr-pvrinput-2011.09.17.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/vdr-plugin-pvrinput-3ee6b964382f38715f4a4fe57bd4760044f9a58a"

src_prepare() {
	vdr-plugin-2_src_prepare

	fix_vdr_libsi_include reader.c

	epatch "${FILESDIR}/missing-include.diff"

	# disable depicated i18n crap
	sed -e "s:^extern[[:space:]]*const[[:space:]]*tI18nPhrase://extern const tI18nPhrase:" -i po/i18n.h
}

src_install() {
	vdr-plugin-2_src_install

	dodoc TODO FAQ example/channels.conf_*
}
