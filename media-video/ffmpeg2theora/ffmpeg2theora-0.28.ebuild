# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ffmpeg2theora/ffmpeg2theora-0.28.ebuild,v 1.7 2013/08/11 22:51:04 aballier Exp $

EAPI=2

DESCRIPTION="A simple converter to create Ogg Theora files."
HOMEPAGE="http://www.v2v.cc/~j/ffmpeg2theora/"
SRC_URI="http://www.v2v.cc/~j/${PN}/downloads/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE="debug kate"

RDEPEND="|| ( media-libs/libpostproc <media-video/libav-0.8.2-r1 media-video/ffmpeg:0 )
	virtual/ffmpeg
	>=media-libs/libvorbis-1.1
	>=media-libs/libogg-1.1
	>=media-libs/libtheora-1.1[encode]
	kate? ( >=media-libs/libkate-0.3.7 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=dev-util/scons-1"

pkg_setup() {
	mysconsopts=(
		"APPEND_CCFLAGS=${CFLAGS}"
		"APPEND_LINKFLAGS=${LDFLAGS}"
		"debug=$(use debug && echo 1 || echo 0)"
		"prefix=/usr"
		"mandir=PREFIX/share/man"
		"destdir=${D}"
		"libkate=$(use kate && echo 1 || echo 0)"
		)
}

src_compile() {
	scons "${mysconsopts[@]}" || die
}

src_install() {
	scons "${mysconsopts[@]}" install || die
	dodoc AUTHORS ChangeLog README subtitles.txt TODO
}
