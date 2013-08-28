# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl2-image/sdl2-image-2.0.0.ebuild,v 1.1 2013/08/28 21:48:06 hasufell Exp $

EAPI=5
inherit eutils

MY_P=SDL2_image-${PV}
DESCRIPTION="Image file loading library"
HOMEPAGE="http://www.libsdl.org/projects/SDL_image/"
SRC_URI="http://www.libsdl.org/projects/SDL_image/release/${MY_P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gif jpeg png static-libs tiff webp"

RDEPEND="
	media-libs/libsdl2
	sys-libs/zlib
	png? ( media-libs/libpng:0 )
	jpeg? ( virtual/jpeg )
	tiff? ( media-libs/tiff )
	webp? ( media-libs/libwebp )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		--disable-sdltest \
		--enable-bmp \
		$(use_enable gif) \
		$(use_enable jpeg jpg) \
		--disable-jpg-shared \
		--enable-lbm \
		--enable-pcx \
		$(use_enable png) \
		--disable-png-shared \
		--enable-pnm \
		--enable-tga \
		$(use_enable tiff tif) \
		--disable-tif-shared \
		--enable-xcf \
		--enable-xpm \
		--enable-xv \
		$(use_enable webp) \
		--disable-webp-shared
}

src_install() {
	emake DESTDIR="${D}" install
	newbin .libs/showimage showimage2
	dodoc {CHANGES,README}.txt
	use static-libs || prune_libtool_files
}
