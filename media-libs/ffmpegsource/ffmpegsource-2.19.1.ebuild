# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ffmpegsource/ffmpegsource-2.19.1.ebuild,v 1.1 2014/04/09 21:27:59 tomwij Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=1

inherit autotools-utils

DESCRIPTION="A libav/ffmpeg based source library for easy frame accurate access"
HOMEPAGE="https://github.com/FFMS/ffms2"
SRC_URI="https://github.com/FFMS/ffms2/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/3"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

RDEPEND="
	sys-libs/zlib
	>=virtual/ffmpeg-9
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"
S="${WORKDIR}/ffms2-${PV}"
