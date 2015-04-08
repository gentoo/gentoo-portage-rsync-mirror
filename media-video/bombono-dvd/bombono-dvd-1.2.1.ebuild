# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/bombono-dvd/bombono-dvd-1.2.1.ebuild,v 1.7 2012/08/11 16:20:50 dilfridge Exp $

EAPI=4
SCONS_MIN_VERSION="0.96.1"

inherit base scons-utils toolchain-funcs flag-o-matic virtualx

DESCRIPTION="GUI DVD authoring program"
HOMEPAGE="http://www.bombono.org/"
SRC_URI="mirror://sourceforge/bombono/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="amd64 x86"

IUSE="gnome"

COMMONDEPEND="
	app-i18n/enca
	app-cdr/dvd+rw-tools
	dev-cpp/gtkmm:2.4
	dev-cpp/libxmlpp:2.6
	>=dev-libs/boost-1.47
	media-libs/libdvdread
	media-sound/twolame
	media-video/dvdauthor
	virtual/cdrtools
	virtual/ffmpeg
	>=media-video/mjpegtools-1.8.0
	x11-libs/gtk+:2
"
RDEPEND="${COMMONDEPEND}
	gnome?	( gnome-base/gvfs )
"
DEPEND="${COMMONDEPEND}
	virtual/pkgconfig
"

RESTRICT=test
# bug 419655

PATCHES=(
	"${FILESDIR}/${PN}-1.0.1-cflags.patch"
	"${FILESDIR}/${PN}-1.2.0-cdrtools.patch"
	"${FILESDIR}/${PN}-1.2.1-glib.patch"
)

src_configure() {
	append-flags -DBOOST_SYSTEM_NO_DEPRECATED -DBOOST_FILESYSTEM_VERSION=2
	myesconsargs=(
		CC="$(tc-getCC)"
		CXX="$(tc-getCXX)"
		CFLAGS="${CFLAGS}"
		CXXFLAGS="${CXXFLAGS}"
		DESTDIR="${D}"
		LDFLAGS="${LDFLAGS}"
		USE_EXT_BOOST=1
		PREFIX="${EPREFIX}/usr"
	)
}

src_compile() {
	nonfatal escons \
		|| die "Please add ${S}/config.opts when filing bugs reports!"
}

src_test() {
	VIRTUALX_COMMAND="escons TEST=1" virtualmake
}

src_install() {
	nonfatal escons install || die "Please add ${S}/config.opts when filing bugs reports!"
}
