# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-markad/vdr-markad-0.1.2.ebuild,v 1.4 2012/03/02 17:18:35 hd_brummy Exp $

EAPI="4"

inherit vdr-plugin eutils

VERSION="578" # every bump, new version

DESCRIPTION="VDR Plugin: marks advertisements in VDR recordings"
HOMEPAGE="http://projects.vdr-developer.org/projects/plg-markad/"
SRC_URI="mirror://vdr-developerorg/${VERSION}/${P}.tgz"

KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.6
		virtual/ffmpeg[mp3,x264]
		!media-video/noad"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${VDRPLUGIN}-${PV}/plugin"
S2="${WORKDIR}/${VDRPLUGIN}-${PV}/command"

src_prepare() {
	vdr-plugin_src_prepare

	cd "${S2}"
	sed -i Makefile \
		-e "s:\$(CXXFLAGS) \$(OBJS):\$(CXXFLAGS) \$(LDFLAGS) \$(OBJS):"

	if has_version ">=media-video/vdr-1.7.15"; then
		sed -e "s:2001:6419:" -i markad-standalone.cpp
	fi
	epatch "${FILESDIR}/${P}-ffmpeg.patch"
}

src_compile() {
	vdr-plugin_src_compile

	cd "${S2}"
	emake markad || die "Compiling command-line markad binary failed"
}

src_install() {
	vdr-plugin_src_install

	cd "${S2}"
	dobin markad

	insinto /var/lib/markad
	doins -r "${S2}"/logos/*

	cd "${WORKDIR}/${VDRPLUGIN}-${PV}"
	dodoc README HISTORY
}
