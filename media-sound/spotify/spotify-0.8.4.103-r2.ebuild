# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/spotify/spotify-0.8.4.103-r2.ebuild,v 1.1 2012/11/16 05:13:07 prometheanfire Exp $

EAPI=4
inherit pax-utils

DESCRIPTION="Spotify is a social music platform"
HOMEPAGE="https://www.spotify.com/ch-de/download/previews/"
MY_PV="${PV}.g9cb177b.260-1"
MY_P="${PN}-client_${MY_PV}"
SRC_BASE="http://repository.spotify.com/pool/non-free/${PN:0:1}/${PN}/"
#SRC_BASE="http://download.spotify.com/preview/"
SRC_URI="
	x86?   ( ${SRC_BASE}${MY_P}_i386.deb )
	amd64? ( ${SRC_BASE}${MY_P}_amd64.deb )
	"
LICENSE="Spotify"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome pax_kernel pulseaudio"

DEPEND=""
RDEPEND="${DEPEND}
		x11-libs/libX11
		x11-libs/libSM
		x11-libs/libICE
		x11-libs/libXrender
		x11-libs/libXrandr
		x11-libs/libXinerama
		x11-libs/libXext
		x11-libs/libxcb
		x11-libs/libXau
		x11-libs/libXdmcp
		x11-libs/qt-core:4
		x11-libs/qt-gui:4
		x11-libs/qt-webkit:4
		x11-libs/qt-dbus:4
		x11-libs/libXScrnSaver
		media-libs/freetype
		media-libs/fontconfig
		media-libs/alsa-lib
		dev-libs/openssl:0
		dev-libs/glib:2
		media-libs/libpng:1.2
		dev-db/sqlite:3
		sys-libs/zlib
		app-arch/bzip2
		sys-apps/dbus
		sys-apps/util-linux
		dev-libs/expat
		>=dev-libs/nspr-4.9
		gnome-base/gconf:2
		x11-libs/gtk+:2
		dev-libs/nss
		dev-libs/glib:2
		pulseaudio? ( >=media-sound/pulseaudio-0.9.21 )
		gnome? ( gnome-extra/gnome-integration-spotify )"

RESTRICT="mirror strip"

src_unpack() {
	mkdir "${P}"
	cd "${P}"
	unpack ${A}
	unpack ./data.tar.gz
}

src_prepare() {
	# link against openssl-1.0.0 as it crashes with 0.9.8
	sed -i \
		-e 's/\(lib\(ssl\|crypto\).so\).0.9.8/\1.1.0.0/g' \
		usr/share/spotify/spotify || die "sed failed"
	# different NSPR / NSS library names for some reason
	sed -i \
		-e 's/\(lib\(nss3\|nssutil3\|smime3\).so\).1d/\1.12/g' \
		-e 's/\(lib\(plc4\|nspr4\).so\).0d\(.\)/\1.9\3\3/g' \
		usr/share/spotify/libcef.so || die "sed failed"
	# Fix desktop entry to launch spotify-dbus.py for GNOME integration
	if use gnome ; then
	sed -i \
		-e 's/spotify \%U/spotify-dbus.py \%U/g' \
		usr/share/applications/spotify.desktop || die "sed failed"
	fi
	#and fix other stuff in the desktop file as well
	sed -i \
		-e 's/x-scheme-handler\/spotify$/x-scheme-handler\/spotify\;/g' \
		-e 's/AudioVideo$/AudioVideo\;/g' \
		usr/share/applications/spotify.desktop || die "sed failed"
}

src_install() {
	dodoc usr/share/doc/spotify-client/changelog.Debian.gz
	dodoc usr/share/doc/spotify-client/copyright
	insinto /usr/share/applications
	doins usr/share/applications/*.desktop
	insinto /usr/share/pixmaps
	doins usr/share/pixmaps/*.png

	# install in /opt/spotify
	SPOTIFY_HOME=/opt/spotify
	dodir ${SPOTIFY_HOME}
	insinto ${SPOTIFY_HOME}
	doins -r usr/share/spotify/*
	fperms +x ${SPOTIFY_HOME}/spotify
	dodir /usr/share
	dosym ${SPOTIFY_HOME} /usr/share/spotify

	dodir /usr/bin
	cat <<-EOF >"${D}"/usr/bin/spotify
		#! /bin/sh
		LD_PRELOAD="\${LD_PRELOAD} /usr/share/spotify/libcef.so"
		export LD_PRELOAD
		exec ${SPOTIFY_HOME}/spotify "\$@"
	EOF
	fperms +x /usr/bin/spotify

	# revdep-rebuild produces a false positive because of symbol versioning
	dodir /etc/revdep-rebuild
	cat <<-EOF >"${D}"/etc/revdep-rebuild/10${PN}
		SEARCH_DIRS_MASK="${SPOTIFY_HOME}"
	EOF

	if use pax_kernel; then
		#create the headers, reset them to default, then paxmark -m them
		pax-mark C "${ED}"/opt/${PN}/${PN} || die
		pax-mark z "${ED}"/opt/${PN}/${PN} || die
		pax-mark m "${ED}"/opt/${PN}/${PN} || die
		eqawarn "You have set USE=pax_kernel meaning that you intendto run"
		eqawarn "${PN} under a PaX enabled kernel.  To do so, we must modify"
		eqawarn "the ${PN} binary itself and this *may* lead to breakage!  If"
		eqawarn "you suspect that ${PN} is being broken by this modification,"
		eqawarn "please open a bug."
	fi
}

pkg_postinst() {
	ewarn "If Spotify crashes after an upgrade its cache may be corrupt."
	ewarn "To remove the cache:"
	ewarn "rm -rf ~/.cache/spotify"
}
