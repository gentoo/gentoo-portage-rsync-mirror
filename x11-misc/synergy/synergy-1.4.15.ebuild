# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/synergy/synergy-1.4.15.ebuild,v 1.7 2014/03/01 18:37:11 jer Exp $

EAPI=5

inherit eutils flag-o-matic gnome2-utils cmake-utils qt4-r2

DESCRIPTION="Lets you easily share a single mouse and keyboard between multiple computers."
HOMEPAGE="http://synergy-foss.org/"
SRC_URI="http://${PN}.googlecode.com/files/${P}-Source.tar.gz
	http://dev.gentoo.org/~hasufell/distfiles/${PN}.png"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ppc ppc64 ~sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="qt4"

COMMON_DEPEND="
	>=dev-libs/crypto++-5.6.2
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libXtst
	qt4? ( dev-qt/qtcore:4 dev-qt/qtgui:4 )
"
DEPEND="${COMMON_DEPEND}
	x11-proto/kbproto
	x11-proto/randrproto
	x11-proto/xextproto
	x11-proto/xineramaproto
	x11-proto/xproto
"
RDEPEND="${COMMON_DEPEND}
	qt4? ( !x11-misc/qsynergy )
"

PATCHES=(
	"${FILESDIR}/${PN}-1.4.12-pthread.patch"
	"${FILESDIR}/${P}-cryptopp.patch"
)

S=${WORKDIR}/${P}-Source

src_configure() {
	cmake-utils_src_configure

	if use qt4 ; then
		cd src/gui || die
		qt4-r2_src_configure
	fi
}

src_compile() {
	cmake-utils_src_compile

	if use qt4 ; then
		cd src/gui || die
		qt4-r2_src_compile
	fi
}

src_install () {
	dobin bin/${PN}{c,s}

	if use qt4 ; then
		newbin bin/${PN} qsynergy
		newicon -s 256 "${DISTDIR}"/${PN}.png q${PN}.png
		make_desktop_entry q${PN} ${PN/s/S} q${PN} Utility;
	fi

	insinto /etc
	newins doc/synergy.conf.example synergy.conf

	newman doc/${PN}c.man ${PN}c.1
	newman doc/${PN}s.man ${PN}s.1

	dodoc README doc/synergy.conf.example* ChangeLog
}

pkg_preinst() {
	use qt4 && gnome2_icon_savelist
}

pkg_postinst() {
	use qt4 && gnome2_icon_cache_update
}

pkg_postrm() {
	use qt4 && gnome2_icon_cache_update
}
