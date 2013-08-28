# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/smpeg2/smpeg2-2.0.0.ebuild,v 1.1 2013/08/28 21:42:16 hasufell Exp $

EAPI=5
inherit eutils toolchain-funcs autotools

MY_P=smpeg-${PV}
DESCRIPTION="SDL MPEG Player Library"
HOMEPAGE="http://icculus.org/smpeg/"
SRC_URI="http://dev.gentoo.org/~hasufell/distfiles/${MY_P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug mmx static-libs"

DEPEND="media-libs/libsdl2"
RDEPEND="${DEPEND}"

DOCS=( CHANGES README README.SDL_mixer TODO )

S=${WORKDIR}/${MY_P}

src_prepare() {
	# avoid file collision with media-libs/smpeg
	sed -i \
		-e '/plaympeg/d' \
		Makefile.am || die

	AT_M4DIR="/usr/share/aclocal acinclude" eautoreconf
}

src_configure() {
	tc-export CC CXX RANLIB AR

	# the debug option is bogus ... all it does is add extra
	# optimizations if you pass --disable-debug
	econf \
		$(use_enable static-libs static) \
		--disable-rpath \
		--enable-debug \
		--disable-sdltest \
		$(use_enable mmx) \
		$(use_enable debug assertions)
}

src_install() {
	default
	use static-libs || prune_libtool_files
}
