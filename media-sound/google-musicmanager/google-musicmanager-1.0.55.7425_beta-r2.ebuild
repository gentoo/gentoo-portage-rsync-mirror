# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/google-musicmanager/google-musicmanager-1.0.55.7425_beta-r2.ebuild,v 1.2 2013/03/01 01:19:56 ottxor Exp $

EAPI=5

inherit eutils unpacker

MY_URL="http://dl.google.com/linux/musicmanager/deb/pool/main/${P:0:1}/${PN}-beta"
MY_PKG="${PN}-beta_${PV/_beta}-r0_i386.deb"

DESCRIPTION="Google Music Manager is a application for adding music to your Google Music library."
HOMEPAGE="http://music.google.com"
SRC_URI="x86? ( ${MY_URL}/${MY_PKG} )
	amd64? ( ${MY_URL}/${MY_PKG/i386/amd64} )"

LICENSE="Google-TOS Apache-2.0 MIT LGPL-2.1 gSOAP BSD FDL-1.2 MPL-1.1 openssl ZLIB libtiff"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="log"

RESTRICT="strip mirror"

RDEPEND="
	dev-libs/expat
	dev-libs/glib:2
	media-libs/flac
	media-libs/fontconfig
	media-libs/freetype:2
	media-libs/libogg
	media-libs/libvorbis
	net-dns/libidn
	sys-libs/glibc
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-webkit:4
	log? ( dev-libs/log4cxx )
	"

DEPEND="app-arch/xz-utils
	app-admin/chrpath"

INSTALL_BASE="opt/google/musicmanager"

QA_TEXTRELS="${INSTALL_BASE}/libmpgdec.so.0"

QA_FLAGS_IGNORED="${INSTALL_BASE}/.*"

S="${WORKDIR}/${INSTALL_BASE}"

pkg_nofetch() {
	einfo "This version is no longer available from Google."
	einfo "Note that Gentoo cannot mirror the distfiles due to license reasons, so we have to follow the bump."
	einfo "Please file a version bump bug on http://bugs.gentoo.org (search existing bugs for ${PN} first!)."
}

pkg_setup() {
	if type -p ifconfig > /dev/null && ! ifconfig | grep -Eq "^(eth|wlan)" ; then
		ewarn "${PN} needs at least one network interface named eth* or wlan* (bug #455896 and bug #459816)"
	fi
}

src_install() {
	insinto "/${INSTALL_BASE}"
	doins config.xml product_logo*

	exeinto "/${INSTALL_BASE}"
	chrpath -d MusicManager || die
	doexe MusicManager google-musicmanager minidump_upload
	#TODO unbundle this
	doexe libaacdec.so libaudioenc.so.0 libmpgdec.so.0 libid3tag.so

	dosym /"${INSTALL_BASE}"/google-musicmanager /opt/bin/google-musicmanager

	local icon size
	for icon in product_logo_*.png; do
		size=${icon#product_logo_}
		size=${size%.png}
		newicon -s "${size}" "${icon}" ${PN}.png
	done
	domenu ${PN}.desktop
}
