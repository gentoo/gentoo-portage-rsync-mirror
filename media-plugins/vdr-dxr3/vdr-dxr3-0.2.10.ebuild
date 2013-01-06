# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-dxr3/vdr-dxr3-0.2.10.ebuild,v 1.3 2011/04/06 17:35:19 idl0r Exp $

EAPI="3"

inherit vdr-plugin versionator flag-o-matic

DESCRIPTION="VDR plugin: Use a dxr3 or hw+ card as output device"
HOMEPAGE="http://sourceforge.net/projects/dxr3plugin/"
SRC_URI="mirror://sourceforge/dxr3plugin/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-video/em8300-libraries
	>=media-video/vdr-1.6.0
	virtual/ffmpeg"
RDEPEND="${DEPEND}"

src_prepare() {
	vdr-plugin_src_prepare

	cd "${S}"
	sed -i Makefile -e 's:^FFMDIR =.*$:FFMDIR=/usr/include/ffmpeg:'

	if has_version ">=virtual/ffmpeg-0.4.9_p20080326"; then
		epatch "${FILESDIR}/${PN}-0.2.8-ffmpeg-includes.diff"
	fi
	# UINT64_C is needed by ffmpeg headers
	append-flags -D__STDC_CONSTANT_MACROS
}
