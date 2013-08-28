# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl2-net/sdl2-net-2.0.0.ebuild,v 1.1 2013/08/28 21:46:02 hasufell Exp $

EAPI=5
inherit eutils

MY_P=SDL2_net-${PV}
DESCRIPTION="Simple Direct Media Layer Network Support Library"
HOMEPAGE="http://www.libsdl.org/projects/SDL_net/index.html"
SRC_URI="http://www.libsdl.org/projects/SDL_net/release/${MY_P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

RDEPEND="media-libs/libsdl2"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_configure() {
	econf \
		--disable-gui \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc {CHANGES,README}.txt
	use static-libs || prune_libtool_files
}
