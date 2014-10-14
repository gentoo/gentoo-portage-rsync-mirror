# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/cara-bin/cara-bin-1.8.4-r1.ebuild,v 1.1 2014/10/14 07:53:03 jlec Exp $

EAPI=5

MY_PN="${PN%%-bin}"
MY_P="${MY_PN}_${PV}"

DESCRIPTION="Analysis of NMR spectra and Computer Aided Resonance Assignment"
SRC_URI="
	http://www.cara.nmr-software.org/downloads/${MY_P}_linux.gz
	http://dev.gentoo.org/~jlec/distfiles//Start1.2.cara.xz"
HOMEPAGE="http://www.nmr.ch"

LICENSE="CARA"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="lua"

RDEPEND="
	amd64? (
		|| (
			(
				>=media-libs/fontconfig-2.10.92[abi_x86_32]
				>=media-libs/freetype-2.5.0.1[abi_x86_32]
				>=x11-libs/libICE-1.0.8-r1[abi_x86_32]
				>=x11-libs/libSM-1.2.1-r1[abi_x86_32]
				>=x11-libs/libX11-1.6.2[abi_x86_32]
				>=x11-libs/libXcursor-1.1.14[abi_x86_32]
				>=x11-libs/libXext-1.3.2[abi_x86_32]
				>=x11-libs/libXi-1.7.2[abi_x86_32]
				>=x11-libs/libXrandr-1.4.2[abi_x86_32]
				>=x11-libs/libXrender-0.9.8[abi_x86_32]
			)
			app-emulation/emul-linux-x86-xlibs
		)
	)
	x86? (
		media-libs/fontconfig
		media-libs/freetype
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libX11
		x11-libs/libXcursor
		x11-libs/libXext
		x11-libs/libXi
		x11-libs/libXrandr
		x11-libs/libXrender
	)
	virtual/libstdc++
	lua? ( dev-lang/lua )"
DEPEND=""

RESTRICT="mirror"

QA_PREBUILT="opt/cara/*"

S="${WORKDIR}"

src_install() {
	exeinto /opt/cara
	doexe ${MY_P}_linux
	dosym ../cara/${MY_P}_linux /opt/bin/cara
	dodoc Start1.2.cara
}
