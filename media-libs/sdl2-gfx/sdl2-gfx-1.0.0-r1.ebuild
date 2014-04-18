# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl2-gfx/sdl2-gfx-1.0.0-r1.ebuild,v 1.1 2014/04/18 21:08:00 hasufell Exp $

EAPI=5
inherit eutils multilib-minimal

MY_P="${P/sdl2-/SDL2_}"
DESCRIPTION="Graphics drawing primitives library for SDL2"
HOMEPAGE="http://www.ferzkopp.net/joomla/content/view/19/14/"
SRC_URI="http://www.ferzkopp.net/Software/SDL2_gfx/${MY_P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc mmx static-libs"

DEPEND="media-libs/libsdl2[video,${MULTILIB_USEDEP}]"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -i \
		-e 's/ -O / /' \
		configure || die
}

multilib_src_configure() {
	ECONF_SOURCE="${S}" econf \
		$(use_enable mmx) \
		$(use_enable static-libs static)
}

multilib_src_install_all() {
	use doc && dohtml -r Docs/html/*
	prune_libtool_files
}
