# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ffmpeg2theora/ffmpeg2theora-0.29.ebuild,v 1.2 2013/04/04 10:00:42 aballier Exp $

EAPI=4
inherit eutils scons-utils

DESCRIPTION="A simple converter to create Ogg Theora files."
HOMEPAGE="http://www.v2v.cc/~j/ffmpeg2theora/"
SRC_URI="http://www.v2v.cc/~j/${PN}/downloads/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug kate"

# || ( media-libs/libpostproc <media-video/libav-0.8.2-r1 media-video/ffmpeg )
RDEPEND="
	>=media-video/ffmpeg-0.10
	>=media-libs/libvorbis-1.1
	>=media-libs/libogg-1.1
	>=media-libs/libtheora-1.1[encode]
	kate? ( >=media-libs/libkate-0.3.7 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

pkg_setup() {
	myesconsargs=(
		APPEND_CCFLAGS="${CFLAGS}"
		APPEND_LINKFLAGS="${LDFLAGS}"
		debug=$(usex debug 1 0)
		prefix=/usr
		mandir=PREFIX/share/man
		libkate=$(usex kate 1 0)
		)
}

src_compile() {
	escons
}

src_install() {
	escons destdir="${D}" install
	dodoc AUTHORS ChangeLog README subtitles.txt TODO
}
