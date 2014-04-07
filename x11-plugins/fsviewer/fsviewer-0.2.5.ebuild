# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/fsviewer/fsviewer-0.2.5.ebuild,v 1.14 2014/04/07 19:45:04 ssuominen Exp $

EAPI=5
inherit eutils

MY_PN=FSViewer

DESCRIPTION="file system viewer for Window Maker"
HOMEPAGE="http://www.bayernline.de/~gscholz/linux/fsviewer/"
SRC_URI="http://www.bayernline.de/~gscholz/linux/${PN}/${MY_PN}.app-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="dev-libs/expat
	media-libs/tiff:0
	media-libs/giflib
	media-libs/libpng:0
	media-libs/fontconfig
	media-libs/freetype
	sys-libs/zlib
	virtual/jpeg:0
	x11-libs/libproplist
	x11-libs/libSM
	x11-libs/libICE
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXft
	x11-libs/libXmu
	x11-libs/libXpm
	x11-libs/libXrender
	x11-libs/libXt
	x11-proto/xextproto
	x11-proto/xproto
	<x11-wm/windowmaker-0.95.0"
DEPEND=${RDEPEND}

S=${WORKDIR}/${MY_PN}.app-${PV}

DOCS=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-windowmaker.patch
}

src_configure() {
	econf \
		--with-appspath=/usr/lib/GNUstep \
		--with-extralibs=-lXft
}
