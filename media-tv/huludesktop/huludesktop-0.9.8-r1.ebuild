# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/huludesktop/huludesktop-0.9.8-r1.ebuild,v 1.3 2012/11/05 16:38:14 vapier Exp $

EAPI="2"

# since 64bit flash availability is up in the air, make it easy
# to switch to/from multilib in the ebuild
NATIVE64="y"

inherit eutils

DESCRIPTION="Hulu desktop"
HOMEPAGE="http://www.hulu.com/labs/hulu-desktop-linux"
SRC_URI="${NATIVE64:+amd64? ( http://download.hulu.com/${PN}_amd64.deb -> ${P}_amd64.deb )}
	x86? ( http://download.hulu.com/${PN}_i386.deb -> ${P}_i386.deb )"

LICENSE="Hulu-EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="lirc"
RESTRICT="mirror"

NATIVE_DEPEND="sys-libs/zlib
	x11-libs/gtk+:2
	dev-libs/glib:2
	lirc? ( app-misc/lirc )"
RDEPEND="sys-libs/glibc
	www-plugins/adobe-flash"
if [[ ${NATIVE64} == "y" ]] ; then
	RDEPEND+="
		!amd64? ( ${NATIVE_DEPEND} )
		amd64? (
			app-emulation/emul-linux-x86-baselibs
			app-emulation/emul-linux-x86-gtklibs
		)"
else
	RDEPEND+="
		${NATIVE_DEPEND}
		amd64? (
			=www-plugins/adobe-flash-10.2*
			=www-plugins/adobe-flash-10.0*
		)"
fi
DEPEND=""

QA_PREBUILT="opt/bin/huludesktop.bin"

src_unpack() {
	unpack ${A} ./data.tar.gz
}

src_install() {
	insinto /etc/${PN}
	doins etc/${PN}/hd_keymap.ini || die

	into /opt
	dobin "${FILESDIR}"/${PN} || die
	newbin usr/bin/${PN} ${PN}.bin || die

	domenu usr/share/applications/${PN}.desktop || die
	doicon usr/share/pixmaps/${PN}.png || die
	dodoc usr/share/doc/${PN}/README
}
