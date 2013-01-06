# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/uae/uae-0.8.29-r1.ebuild,v 1.3 2011/03/27 10:31:29 nirbheek Exp $

EAPI="1"

inherit eutils

DESCRIPTION="The Umiquious Amiga Emulator"
HOMEPAGE="http://www.amigaemulator.org/"
SRC_URI="ftp://ftp.amigaemulator.org/pub/uae/sources/develop/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="sdl alsa scsi"

DEPEND="sdl? ( media-libs/libsdl
		   media-libs/sdl-gfx
		   x11-libs/gtk+:2
		   alsa? ( media-libs/alsa-lib )
	)
	!sdl? ( x11-libs/libXext
		 x11-libs/gtk+:2
	)
	alsa? ( media-libs/alsa-lib )
	scsi? ( app-cdr/cdrtools )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/uae-0.8.25-allow_spaces_in_zip_filenames.diff
	epatch "${FILESDIR}"/uae-0.8.25-struct_uae_wrong_fields_name.diff
	epatch "${FILESDIR}"/${PN}-0.8.26-uae_reset_args.diff
	cp "${FILESDIR}"/sdlgfx.h "${S}"/src
}

src_compile() {
	# disabling lots of options, cause many code-paths are broken, these should compile,
	# if you want/need other options, please test if they work with other combinations
	# before opening a bug
	econf --enable-ui --with-x --without-svgalib \
		--without-asciiart --without-sdl-sound --enable-threads \
		$(use_with sdl) $(use_with sdl sdl-gfx) \
		$(use_with alsa) \
		$(use_enable scsi scsi-device) || die "econf failed"

	emake -j1 || die "emake failed"
}

src_install() {
	dobin uae readdisk || die
	cp docs/unix/README docs/README.unix
	rm -r docs/{AmigaOS,BeOS,pOS,translated,unix}
	dodoc docs/*

	insinto /usr/share/uae/amiga-tools
	doins amiga/{*hack,trans*,uae*}
}

pkg_postinst() {
	elog
	elog "Upstream recomends using SDL graphics (with an environment variable)"
	elog "SDL_VIDEO_X11_XRANDR=1 for fullscreen support."
	echo
}
