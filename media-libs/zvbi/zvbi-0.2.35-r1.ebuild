# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/zvbi/zvbi-0.2.35-r1.ebuild,v 1.1 2014/03/28 06:44:56 aballier Exp $

EAPI=5
inherit eutils libtool multilib-minimal

DESCRIPTION="VBI Decoding Library for Zapping"
SRC_URI="mirror://sourceforge/zapping/${P}.tar.bz2"
HOMEPAGE="http://zapping.sourceforge.net"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE="doc dvb nls static-libs v4l X"

RDEPEND=">=media-libs/libpng-1.4[${MULTILIB_USEDEP}]
	sys-libs/zlib[${MULTILIB_USEDEP}]
	nls? ( virtual/libintl[${MULTILIB_USEDEP}] )
	X? ( x11-libs/libX11[${MULTILIB_USEDEP}] )"
DEPEND="${RDEPEND}
	virtual/os-headers
	doc? ( app-doc/doxygen )
	nls? ( sys-devel/gettext )
	X? ( x11-libs/libXt )"

src_prepare() {
	elibtoolize
}

multilib_src_configure() {
	ECONF_SOURCE="${S}" econf \
		$(use_enable static-libs static) \
		$(use_enable v4l) \
		$(use_enable dvb) \
		$(use_enable nls) \
		$(use_with X x) \
		$(multilib_is_native_abi && use_with doc doxygen || echo "--without-doxygen")
}

multilib_src_install() {
	emake DESTDIR="${D}" install

	multilib_is_native_abi && use doc && dohtml -a png,gif,html,css doc/html/*
}

multilib_src_install_all() {
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO

	find "${D}" -name '*.la' -delete
}
