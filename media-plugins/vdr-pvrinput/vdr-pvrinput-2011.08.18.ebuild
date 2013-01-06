# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-pvrinput/vdr-pvrinput-2011.08.18.ebuild,v 1.4 2012/04/22 22:43:14 mr_bones_ Exp $

EAPI="4"

inherit vdr-plugin eutils versionator

VERSION="668" # every bump, new version!

MY_PV=$(replace_all_version_separators '-')
MY_P="${PN}-${MY_PV}"

DESCRIPTION="VDR Plugin: Use a PVR* card as input device"
HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-pvrinput"
SRC_URI="mirror://vdr-developerorg/${VERSION}/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P#vdr-}"

src_prepare() {
	vdr-plugin_src_prepare

	fix_vdr_libsi_include reader.c

	epatch "${FILESDIR}/missing-include.diff"
}

src_install() {
	vdr-plugin_src_install

	dodoc TODO FAQ example/channels.conf_*
}
