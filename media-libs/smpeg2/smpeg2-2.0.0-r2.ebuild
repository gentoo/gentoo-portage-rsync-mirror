# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/smpeg2/smpeg2-2.0.0-r2.ebuild,v 1.1 2014/04/18 21:22:11 hasufell Exp $

EAPI=5
inherit eutils toolchain-funcs autotools multilib-minimal

MY_P=smpeg-${PV}
DESCRIPTION="SDL MPEG Player Library"
HOMEPAGE="http://icculus.org/smpeg/"
SRC_URI="http://dev.gentoo.org/~hasufell/distfiles/${MY_P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug mmx static-libs"

DEPEND="media-libs/libsdl2[${MULTILIB_USEDEP}]"
RDEPEND="${DEPEND}"

DOCS=( CHANGES README README.SDL_mixer TODO )

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-smpeg2-config.patch

	# avoid file collision with media-libs/smpeg
	sed -i \
		-e '/plaympeg/d' \
		Makefile.am || die

	AT_M4DIR="/usr/share/aclocal acinclude" eautoreconf
}

multilib_src_configure() {
	# the debug option is bogus ... all it does is add extra
	# optimizations if you pass --disable-debug
	ECONF_SOURCE="${S}" econf \
		$(use_enable static-libs static) \
		--disable-rpath \
		--enable-debug \
		--disable-sdltest \
		$(use_enable mmx) \
		$(use_enable debug assertions)
}

multilib_src_install_all() {
	use static-libs || prune_libtool_files
}
