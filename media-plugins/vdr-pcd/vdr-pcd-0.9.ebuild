# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-pcd/vdr-pcd-0.9.ebuild,v 1.6 2011/04/06 17:20:39 idl0r Exp $

EAPI="3"

inherit vdr-plugin flag-o-matic

DESCRIPTION="VDR Plugin: adds the functionality to view PhotoCDs"
HOMEPAGE="http://www.heiligenmann.de/vdr/vdr/plugins/pcd.html"
SRC_URI="http://www.heiligenmann.de/vdr/download/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.4.4
		>=virtual/ffmpeg-0.4.9_p20070616"
RDEPEND="${DEPEND}"

src_prepare() {
	vdr-plugin_src_prepare

	if has_version ">=virtual/ffmpeg-0.4.9_p20080326" ; then
		sed -e "s:ffmpeg/avcodec.h:libavcodec/avcodec.h:" -i mpeg.h
	fi

	# UINT64_C is needed by ffmpeg headers
	append-flags -D__STDC_CONSTANT_MACROS
}
