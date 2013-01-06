# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/tucnak2/tucnak2-2.46.ebuild,v 1.5 2012/05/03 03:48:56 jdhore Exp $

EAPI=2
inherit eutils autotools

DESCRIPTION="Amateur Radio VHF Contest Logbook"
HOMEPAGE="http://tucnak.nagano.cz"
SRC_URI="http://tucnak.nagano.cz/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="alsa fftw ftdi gpm hamlib suid"

RDEPEND=">=dev-libs/glib-2
	media-libs/libsndfile
	>=media-libs/libsdl-1.2
	alsa? ( media-libs/alsa-lib )
	fftw? ( sci-libs/fftw:3.0 )
	ftdi? ( dev-embedded/libftdi )
	gpm? ( sys-libs/gpm )
	hamlib? ( media-libs/hamlib )
	>=media-libs/libpng-1.2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}/${PN}-2.39-doc.diff" \
		"${FILESDIR}/${PN}-2.42-appname.diff" \
		"${FILESDIR}/${PN}-soundwrapper.diff"
	eautoreconf
}

src_configure() {
	econf $(use_with alsa) $(use_with ftdi) \
		$(use_with gpm) $(use_with hamlib) \
		$(use_with fftw fftw3) --with-sdl
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	doman debian/tucnak2.1 || die "doman failed"
	dodoc AUTHORS ChangeLog TODO doc/NAVOD.pdf || die "dodoc failed"
	if use suid ; then
		fperms 4711 /usr/bin/soundwrapper || die "fperms failed"
	fi
}

pkg_postinst() {
	elog "In order to use sound with tucnak2 add yourself to the 'audio' group"
	elog "and to key your rig via the parport add yourself to the 'lp' group"
	elog ""
	elog "tucnak2 can be used with the following additional packages:"
	elog "	   media-radio/cwdaemon  : Morse output via code cwdaemon"
	elog "                             (No need to recompile)"
	if use suid ; then
		ewarn "You have choosen to install the little helper program 'soundwrapper'"
		ewarn "setuid by setting USE=suid. That helper is only needed if you"
		ewarn "want to use morse sidetone output via the PC speaker."
		ewarn ""
		ewarn "While the helper should be safe by design be aware that setting"
		ewarn "any program setuid is a security risk."
	fi
}
