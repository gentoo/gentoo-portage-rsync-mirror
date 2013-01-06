# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/sflphone/sflphone-0.9.8.4.ebuild,v 1.7 2011/03/21 23:20:39 nirbheek Exp $

EAPI="2"

inherit autotools eutils

DESCRIPTION="SFLphone is a robust standards-compliant enterprise softphone, for desktop and embedded systems."
HOMEPAGE="http://www.sflphone.org/"
SRC_URI="http://www.elvanor.net/files/gentoo/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="debug gnome gsm iax networkmanager speex"

CDEPEND="media-sound/pulseaudio
	media-libs/libsamplerate
	net-libs/ccrtp
	net-libs/libzrtpcpp
	net-libs/pjsip
	dev-cpp/commoncpp2
	sys-apps/dbus
	dev-libs/openssl
	dev-libs/expat
	media-libs/alsa-lib
	media-libs/celt
	dev-libs/libpcre
	gsm? ( media-sound/gsm )
	speex? ( media-libs/speex )
	networkmanager? ( net-misc/networkmanager )
	iax? ( net-libs/iax )
	gnome? ( dev-libs/atk
		dev-libs/check
		dev-libs/log4c
		gnome-base/libgnomeui
		gnome-base/orbit:2
		gnome-extra/evolution-data-server
		media-libs/libart_lgpl
		media-libs/freetype
		media-libs/fontconfig
		net-libs/libsoup:2.4
		x11-libs/cairo
		x11-libs/libnotify
		x11-libs/libICE
		x11-libs/libSM )"

DEPEND="${CDEPEND}
		gnome? ( app-text/gnome-doc-utils )"

RDEPEND="${CDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-libnotify-0.7.patch

	if ! use gnome; then
		ewarn
		ewarn "No clients selected. Use USE=gnome to get the gnome client."
		ewarn "See"
		ewarn "https://projects.savoirfairelinux.com/repositories/browse/sflphone/tools/pysflphone"
		ewarn "for a python command line client."
		ewarn
	fi

	cd sflphone-common
	#remove "target" from lib-names, remove dep to shipped pjsip
	sed -i -e 's/-$(target)//' \
		-e '/^\t\t\t-L/ d' \
		-e 's!-I$(src)/libs/pjproject!-I/usr/include!' \
		globals.mak || die "sed failed."
	#respect CXXFLAGS
	sed -i -e 's/CXXFLAGS="-g/CXXFLAGS="-g $CXXFLAGS /' \
		configure.ac || die "sed failed."
	rm -r libs/pjproject
	eautoreconf

	#TODO: remove shipped dbus-c++ use system one (see #220767)
	#TODO: remove shipped utilspp (from curlpp), use system one, see #55185

	if use gnome; then
		cd ../sflphone-client-gnome
		#fix as-needed
		sed -i -e "s/X11_LIBS)/X11_LIBS) -lebook-1.2/" src/Makefile.am || die "sed failed."
		eautoreconf
	fi
}

src_configure() {
	cd sflphone-common
	econf --disable-dependency-tracking \
		$(use_with debug) \
		$(use_with gsm) \
		$(use_with speex) \
		$(use_with iax iax2) \
		$(use_with networkmanager) || die "econf failed."

	if use gnome; then
		cd ../sflphone-client-gnome
		econf || die "econf failed."
	fi
}

src_compile() {
	cd sflphone-common
	emake || die "emake failed."

	if use gnome; then
		cd ../sflphone-client-gnome
		emake || die "emake failed."
	fi
}

src_install() {
	cd sflphone-common
	emake -j1 DESTDIR="${D}" install || die "emake install failed"
	dodoc test/sflphonedrc-sample

	if use gnome; then
		cd ../sflphone-client-gnome
		emake DESTDIR="${D}" install || die "emake install failed"
	fi
}

pkg_postinst() {
	elog
	elog "You need to restart dbus, if you want to access"
	elog "sflphoned through dbus."
	elog
	elog
	elog "If you use the command line client"
	elog "(https://projects.savoirfairelinux.com/repositories/browse/sflphone/tools/pysflphone)"
	elog "extract /usr/share/doc/${PF}/${PN}drc-sample to"
	elog "~/.config/${PN}/${PN}drc for example config."
	elog
	elog
	elog "For calls out of your browser have a look in sflphone-callto"
	elog "and sflphone-handler. You should consider to install"
	elog "the \"Telify\" Firefox addon. See"
	elog "https://projects.savoirfairelinux.com/repositories/browse/sflphone/tools"
	elog
	if use gnome; then
		elog
		elog "sflphone-client-gnome: To manage your contacts you need"
		elog "mail-client/evolution or access to an evolution-data-server"
		elog "connected backend."
		elog
	fi
}
