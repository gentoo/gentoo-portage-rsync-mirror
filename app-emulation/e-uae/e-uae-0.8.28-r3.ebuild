# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/e-uae/e-uae-0.8.28-r3.ebuild,v 1.11 2012/12/11 18:21:18 grobian Exp $

EAPI="1"

inherit eutils flag-o-matic pax-utils

DESCRIPTION="The Ubiquitous Amiga Emulator with an emulation core largely based on WinUAE"
HOMEPAGE="http://www.rcdrummond.net/uae/"
SRC_URI="http://www.rcdrummond.net/uae/${P}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="X dga ncurses sdl gtk alsa oss sdl-sound capslib"

# Note: opposed to ./configure --help zlib support required! Check
# src/Makefile.am that includes zfile.c unconditionaly.
RDEPEND="X? ( x11-libs/libXt
			 x11-libs/libxkbfile
			 x11-libs/libXext
			 dga? ( x11-libs/libXxf86dga
				    x11-libs/libXxf86vm )
			)
		!X? ( sdl? ( media-libs/libsdl )
			  !sdl? ( sys-libs/ncurses ) )
		alsa? ( media-libs/alsa-lib )
		!alsa? ( sdl-sound? ( media-libs/sdl-sound ) )
		gtk? ( x11-libs/gtk+:2 )
		capslib? ( games-emulation/caps )
		sys-libs/zlib
		virtual/cdrtools"

DEPEND="$RDEPEND
		X? ( dga? ( x11-proto/xf86vidmodeproto
					x11-proto/xf86dgaproto ) )"

pkg_setup() {
	# Sound setup.
	if use alsa; then
		elog "Choosing alsa as sound target to use."
		myconf="--with-alsa --without-sdl-sound"
	elif use sdl-sound ; then
		if ! use sdl ; then
			ewarn "sdl-sound is not enabled because sdl is switched off. Leaving"
			ewarn "sound on oss autodetection."
			myconf="--without-alsa --without-sdl-sound"
			ebeep
		else
			elog "Choosing sdl-sound as sound target to use."
			myconf="--without-alsa --with-sdl-sound"
		fi
	elif use oss ; then
		elog "Choosing oss as sound target to use."
		ewarn "oss will be autodetected. See output of configure."
		myconf="--without-alsa --without-sdl-sound"
	else
		ewarn "There is no alsa, sdl-sound or oss in USE. Sound target disabled!"
		myconf="--disable-audio"
	fi

	# VIDEO setup. X is autodetected (there is no --with-X option).
	if use X ; then
		elog "Using X11 for video output."
		myconf="$myconf --without-curses --without-sdl-gfx"
		use dga && myconf="$myconf --enable-dga --enable-vidmode"
	elif use sdl ; then
		elog "Using sdl for video output."
		myconf="$myconf --with-sdl --with-sdl-gfx --without-curses"
	elif use ncurses; then
		elog "Using ncurses for video output."
		myconf="$myconf --with-curses --without-sdl-gfx"
	else
		ewarn "There is no X or sdl or ncurses in USE!"
		ewarn "Following upstream falling back on ncurses."
		myconf="$myconf --with-curses --without-sdl-gfx"
		ebeep
	fi

	use gtk && myconf="$myconf --enable-ui --enable-threads"
	use gtk || myconf="$myconf --disable-ui"

	use capslib && myconf="$myconf --with-caps"

	myconf="$myconf --with-zlib"

	# And explicitly state defaults:
	myconf="$myconf --enable-aga"
	myconf="$myconf --enable-autoconfig --enable-scsi-device --enable-cdtv --enable-cd32"
	myconf="$myconf --enable-bsdsock"
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-shm-crash.patch"
	epatch "${FILESDIR}/${P}-fix-joystick-conflicts.patch"
	epatch "${FILESDIR}/${P}-fix-atoscroll-screen-support.patch"
	epatch "${FILESDIR}/${P}-fix-JIT-cache-on-NX-cpu.patch"
	epatch "${FILESDIR}/${P}-gtkui_64bit_fix.diff"
	epatch "${FILESDIR}/${P}-themes_rendering_fix.diff"
	# bug #425680
	sed -i -e 's/getline/mygetline/' src/gui-none/nogui.c || die
}

src_compile() {
	strip-flags

	econf ${myconf} \
		--with-libscg-includedir=/usr/include/scsilib \
		|| die "./configure failed"

	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	# The emulator needs to be able to create executable heap
	# - doesn't need trampoline emulation though.
	pax-mark me "${D}/usr/bin/uae"

	insinto /usr/share/uae/amiga-tools
	doins amiga/{*hack,trans*,uae*,*.library}

	# Rename it to e-uae
	mv "${D}/usr/bin/uae" "${D}/usr/bin/e-uae"
	mv "${D}/usr/bin/readdisk" "${D}/usr/bin/e-readdisk"
	mv "${D}/usr/share/uae" "${D}/usr/share/${PN}"

	dodoc docs/* README ChangeLog
}
