# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/sflphone/sflphone-1.2.2.ebuild,v 1.1 2013/05/04 22:56:25 elvanor Exp $

EAPI="4"

inherit autotools eutils gnome2

DESCRIPTION="SFLphone is a robust standards-compliant enterprise softphone, for desktop and embedded systems."
HOMEPAGE="http://www.sflphone.org/"
SRC_URI="http://www.elvanor.net/files/gentoo/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doxygen gnome gsm kde networkmanager pulseaudio speex static-libs"

# USE="-iax" does not work. Upstream problem.

CDEPEND="dev-cpp/commoncpp2
	dev-libs/dbus-c++
	dev-libs/expat
	dev-libs/ilbc-rfc3951
	dev-libs/libpcre
	dev-libs/libyaml
	dev-libs/openssl
	media-libs/alsa-lib
	media-libs/celt
	media-libs/libsamplerate
	pulseaudio? ( media-sound/pulseaudio )
	net-libs/ccrtp
	net-libs/libzrtpcpp
	net-libs/pjsip
	sys-apps/dbus
	gnome? ( dev-libs/atk
		dev-libs/check
		gnome-base/libgnomeui
		gnome-base/orbit:2
		gnome-extra/evolution-data-server
		media-libs/fontconfig
		media-libs/freetype
		media-libs/libart_lgpl
		net-libs/libsoup:2.4
		net-libs/webkit-gtk:3
		x11-libs/cairo
		x11-libs/libICE
		x11-libs/libnotify
		x11-libs/libSM )
	gsm? ( media-sound/gsm )
	networkmanager? ( net-misc/networkmanager )
	speex? ( media-libs/speex )"

DEPEND="${CDEPEND}
		>=dev-util/astyle-1.24
		doxygen? ( app-doc/doxygen )
		gnome? ( app-text/gnome-doc-utils )
		virtual/pkgconfig"

RDEPEND="${CDEPEND}"

pkg_setup() {
	#if  use gnome && use kde ; then
	#	elog "Both Gnome and KDE flags are set; preference goes to KDE. Only the KDE client will be built."
	#fi

	if  use kde; then
		elog "The KDE client is not yet available with this ebuild and won't be built."
	fi

	if ! use gnome; then
		ewarn
		ewarn "Select USE=gnome to get a graphicalclient."
		ewarn "See"
		ewarn "https://projects.savoirfairelinux.com/repositories/browse/sflphone/tools/pysflphone"
		ewarn "for a python command line client."
		ewarn
	fi
}

src_prepare() {
	cd "${S}/daemon"
	rm -rf libs/pjproject-2.0.1

	sed -i -e 's!include $(src)/libs/pjproject-2.0.1/build.mak!!' src/audio/codecs/Makefile.in src/audio/codecs/Makefile.am
	sed -i -e 's!--shared -lc $(top_srcdir)/libs/pjproject-2.0.1/third_party/lib/libilbccodec-$(TARGET_NAME).a!-lilbc!' src/audio/codecs/Makefile.am
	sed -i -e 's/-$(target)//' -e '/^\t\t\t-L/ d' -e "s/PJSIP_LIBS=\$(APP_LDFLAGS) \$(APP_LDLIBS)/PJSIP_LIBS=$(pkg-config --libs-only-l libpjproject)/" \
		-e 's!-I$(src)/libs/pjproject-2.0.1!-I/usr/include!' -e 's!include $(src)/libs/pjproject-2.0.1/build.mak!!' \
		globals.mak || die "sed failed."
	# Respect CXXFLAGS
	sed -i -e 's/CXXFLAGS="-g/CXXFLAGS="-g $CXXFLAGS /' \
		configure.ac || die "sed failed."
	eautoreconf
}

src_configure() {
	local myconf=""
	if ! use pulseaudio; then
		myconf="--without-pulse"
	fi

	cd "${S}/daemon"
	econf --disable-dependency-tracking $(use_with debug) $(use_with gsm) \
		$(use_with networkmanager) $(use_with speex) $(use_enable static-libs static) $(use_enable doxygen) ${myconf}

	#if use gnome && ! use kde; then
	if use gnome; then
		cd "${S}/gnome"
		econf $(use_enable static-libs static)
	fi

	#if use kde; then
	#	cd "${S}/kde"
	#	./config.sh --prefix=/usr $(use_enable static-libs static)
#		econf $(use_enable static-libs static)
	#fi
}

src_compile() {
	cd "${S}/daemon"
	emake || die "emake failed."

	#if use gnome && ! use kde; then
	if use gnome; then
		cd ../gnome
		emake || die "emake failed."
	fi

	#if use kde; then
	#	cd ../kde/build
	#	emake || die "emake failed."
	#fi
}

src_install() {
	if use gnome; then
		cd "${S}/gnome"
		gnome2_src_install
	fi

	#if use kde; then
	#	cd "${S}/kde"
	#	emake -j1 DESTDIR="${D}" install || die "emake install failed"
	#	cd ../
	#fi

	cd "${S}/daemon"
	emake -j1 DESTDIR="${D}" install || die "emake install failed"
	dodoc test/sflphonedrc-sample
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
		gnome2_pkg_postinst
		elog
		elog "sflphone-client-gnome: To manage your contacts you need"
		elog "mail-client/evolution or access to an evolution-data-server"
		elog "connected backend."
		elog
	fi
}
