# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/uae/uae-0.8.29.ebuild,v 1.2 2011/03/27 10:31:29 nirbheek Exp $

EAPI="1"

inherit eutils

DESCRIPTION="The Umiquious Amiga Emulator"
HOMEPAGE="http://www.amigaemulator.org/"
SRC_URI="ftp://ftp.amigaemulator.org/pub/uae/sources/develop/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="sdl X dga svga aalib oss alsa sdl-sound scsi ui"

DEPEND="sdl? ( media-libs/libsdl
			   media-libs/sdl-gfx
			   ui? ( x11-libs/gtk+:2 )
			   alsa? ( media-libs/alsa-lib )
			 )
	!sdl? ( X? ( x11-libs/libXext
				 dga? ( x11-libs/libXxf86dga
						x11-libs/libXxf86vm )
				 ui? ( x11-libs/gtk+:2 )
			   )
			!X? ( svga? ( media-libs/svgalib
						  ui? ( sys-libs/ncurses ) )
				  !svga? ( aalib? ( media-libs/aalib
									ui? ( sys-libs/ncurses ) ) )
						   !aalib? ( media-libs/libsdl
									 ui? ( x11-libs/gtk+:2 ) ) )
			alsa? ( media-libs/alsa-lib )
		  )
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

pkg_setup() {
	# See configure.in for possible pathes of logic...
	echo
	elog "It was told by upstream developer Bernd Schmidt that sdl-sound is"
	elog "broken now and alsa driver seems to be not in best shape. So OSS"
	elog "(don't forget alsa emulation of OSS) is prefered, but it'll be"
	elog "autodetected and thus it's possible that uae misses it and you'll"
	elog "have no error but no sound too. Be carful and report this cases."
	echo
	if use sdl ; then
		elog "Enabling sdl for video output."
		my_config="$(use_with sdl) $(use_with sdl sdl-gfx)"
		# SELECT UI
		if use ui ; then
			elog "Using GTK+ for UI."
			my_config="${my_config} $(use_enable ui)"
		else
			elog "You do not have ui in USE. Disabling UI"
			my_config="${my_config} --disable-ui"
		fi
		if use oss ; then
			elog "Disabling alsa and sdl-sound and falling back on oss autodetection."
			elog "You'll have to be carefull: if that fails you'll have no audio."
			my_config="${my_config} --without-sdl-sound --without-alsa"
		elif use sdl-sound ; then
			elog "Enabling sdl-sound for sound output."
			my_config="${my_config} $(use_with sdl-sound)"
		elif use alsa ; then
			elog "Enabling alsa for sound output."
			my_config="${my_config} --without-sdl-sound $(use_with alsa)"
		else
			elog "You have not enabled alsa or sdl-sound in USE."
			elog "Using sound output to file."
			my_config="${my_config} --enable-file-sound"
		fi
	else
		elog "Disabling sdl for all (video and sound)."
		my_config="--without-sdl"
		if use X ; then
			elog "Enabling X11 for video output."
			# Disabling all other GFX to be sure that we'll have what we want.
			my_config="${my_config} --without-svgalib --without-asciiart $(use_with X x)"
			use dga && my_config="${my_config} $(use_enable dga) $(use_enable X vidmode)"
			# SELECT UI
			if use ui ; then
				elog "Using GTK+ for UI."
				my_config="${my_config} $(use_enable ui)"
			else
				elog "You do not have ui in USE. Disabling UI"
				my_config="${my_config} --disable-ui"
			fi
		else
			my_config="${my_config} --without-x"
			if use svga ; then
				elog "Enabling svga for video output."
				my_config="${my_config} $(use_with svga svgalib)"
				if use ui ; then
					elog "Using ncurses for UI."
					my_config="${my_config} $(use_enable ui)"
				else
					elog "You do not have ui in USE. Disabling UI"
					my_config="${my_config} --disable-ui"
				fi
			elif use aalib ; then
				elog "Enabling ASCII art for video output."
				my_config="${my_config} $(use_with aalib svgalib)"
				if use ui ; then
					einfo "Using ncurses for UI."
					my_config="${my_config} $(use_enable ui)"
				else
					elog "You do not have ui in USE. Disabling UI"
					my_config="${my_config} --disable-ui"
				fi
			else
				elog "You have not enabled sdl or X or svga or ncurses in USE!"
				elog "Video output is not selected. Falling back on sdl..."
				my_config="$(use_with sdl) $(use_with sdl sdl-gfx) $(use_with sdl-sound)"
				# SELECT UI
				if use ui ; then
					elog "Using GTK+ for UI."
					my_config="${my_config} $(use_enable ui)"
				else
					elog "You do not have ui in USE. Disabling UI"
					my_config="${my_config} --disable-ui"
				fi
			fi
		fi
		if use oss ; then
			elog "Disabling alsa and sdl-sound and falling back on oss autodetection."
			elog "You'll have to be carefull: if that fails you'll have no audio."
			my_config="${my_config} --without-sdl-sound --without-alsa"
		elif use alsa ; then
			elog "Enabling alsa for sound output."
			my_config="${my_config} $(use_with alsa)"
		else
			use sdl-sound && ewarn "You can not have sdl-sound without sdl."
			elog "You have not enabled alsa in USE."
			elog "Using sound output to file."
			my_config="${my_config} --enable-file-sound"
		fi
	fi
	echo
	my_config="${my_config} $(use_enable scsi scsi-device)"
	my_config="${my_config} --enable-threads"
}

src_compile() {
	econf ${my_config} || die "configure failed"
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
	elog "Upstream recomends using SDL graphics (with an environment variable"
	elog "SDL_VIDEO_X11_XRANDR=1 for fullscreen support."
	echo
}
