# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ffmpegsource/ffmpegsource-2.17.3_pre743.ebuild,v 1.1 2013/02/16 19:24:34 maksbotan Exp $

EAPI=4

AUTOTOOLS_AUTORECONF=1

inherit autotools-utils

DESCRIPTION="An FFmpeg based source library for easy frame accurate access"
HOMEPAGE="https://code.google.com/p/ffmpegsource/"
SRC_URI="http://rion-overlay.googlecode.com/files/${P}.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

RDEPEND="
	sys-libs/zlib
	>=virtual/ffmpeg-0.9
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

src_configure() {
	local myeconfargs=(
		--docdir="${EPREFIX}/usr/share/doc/${PF}/html"
	)

	autotools-utils_src_configure
}
