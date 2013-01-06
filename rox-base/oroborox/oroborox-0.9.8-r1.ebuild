# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/oroborox/oroborox-0.9.8-r1.ebuild,v 1.4 2009/01/18 17:43:42 maekke Exp $

ROX_LIB_VER=1.9.14
inherit rox eutils toolchain-funcs autotools

MY_PN="OroboROX"

DESCRIPTION="OroboROX is a small window manager for the ROX Desktop."
HOMEPAGE="http://rox.sourceforge.net/"
SRC_URI="http://roxos.sunsite.dk/dev-contrib/guido/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
# startup-notification support is disabled by default, probably because it
# doesn't work.
# Also, there is no way to explicitly disable xinerama - It is always detected
# if it's there.
IUSE="xinerama" #startup-notification

DEPEND="
	>=media-libs/freetype-2.0
	x11-proto/xproto
	x11-proto/xextproto
	x11-proto/xf86vidmodeproto
	x11-libs/libXft
	x11-libs/libXpm
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXcomposite
	x11-libs/libXdamage
	xinerama? ( x11-proto/xineramaproto )
	"
	#startup-notification? ( x11-libs/startup-notification )

RDEPEND="
	>=media-libs/freetype-2.0
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXft
	x11-libs/libXpm
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXxf86vm
	xinerama? ( x11-libs/libXinerama )
	"
	#startup-notification? ( x11-libs/startup-notification )

S=${WORKDIR}
SET_PERM=TRUE

APPNAME=${MY_PN}

# OroboROX causes sandbox violations if CHOICESPATH is set to any path.
# see bug #124133
unset CHOICESPATH

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-respectflags.patch
	cd ${MY_PN}/src
	eautoreconf
	tc-export CC
}

src_compile() {
	rox_src_compile

	# Remove the leftover '=build' directory
	cd "${S}/${APPNAME}"
	rm -rf '=build'
}
