# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl2-image/sdl2-image-2.0.0-r1.ebuild,v 1.1 2014/04/18 21:11:48 hasufell Exp $

EAPI=5
inherit eutils multilib-minimal

MY_P=SDL2_image-${PV}
DESCRIPTION="Image file loading library"
HOMEPAGE="http://www.libsdl.org/projects/SDL_image/"
SRC_URI="http://www.libsdl.org/projects/SDL_image/release/${MY_P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gif jpeg png static-libs tiff webp"

RDEPEND="
	media-libs/libsdl2[${MULTILIB_USEDEP}]
	sys-libs/zlib[${MULTILIB_USEDEP}]
	png? ( media-libs/libpng:0[${MULTILIB_USEDEP}] )
	jpeg? ( virtual/jpeg[${MULTILIB_USEDEP}] )
	tiff? ( media-libs/tiff[${MULTILIB_USEDEP}] )
	webp? ( media-libs/libwebp[${MULTILIB_USEDEP}] )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

multilib_src_configure() {
	ECONF_SOURCE="${S}" econf \
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

multilib_src_install() {
	emake DESTDIR="${D}" install
	multilib_is_native_abi && newbin .libs/showimage showimage2
}

multilib_src_install_all() {
	dodoc {CHANGES,README}.txt
	use static-libs || prune_libtool_files
}
