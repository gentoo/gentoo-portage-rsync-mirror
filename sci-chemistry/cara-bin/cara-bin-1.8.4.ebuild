# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/cara-bin/cara-bin-1.8.4.ebuild,v 1.5 2012/09/10 16:20:51 jlec Exp $

EAPI=4

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
		app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-compat )
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
		virtual/libstdc++ )
	lua? ( dev-lang/lua )"
DEPEND=""

RESTRICT="mirror"

QA_PREBUILT="opt/cara/*"

S="${WORKDIR}"

src_install() {
	exeinto /opt/cara
	doexe ${MY_P}_linux
	dosym ${MY_P}_linux /opt/cara/cara
	dodoc Start1.2.cara

	cat >>"${T}"/20cara<<- EOF
	PATH="${EPREFIX}/opt/cara/"
	EOF

	doenvd "${T}"/20cara
}
