# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/irrlicht/irrlicht-1.7.2.ebuild,v 1.6 2011/09/15 03:18:02 ssuominen Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION="open source high performance realtime 3D engine written in C++"
HOMEPAGE="http://irrlicht.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="doc"

RDEPEND="virtual/jpeg
	media-libs/libpng
	app-arch/bzip2
	virtual/opengl
	x11-libs/libX11"
DEPEND="${RDEPEND}
	app-arch/unzip
	x11-proto/xproto
	x11-proto/xf86vidmodeproto"

S=${WORKDIR}/${P}/source/Irrlicht

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
	cd ../..
	edos2unix include/IrrCompileConfig.h
	epatch \
		"${FILESDIR}"/${P}-config.patch \
		"${FILESDIR}"/${P}-demoMake.patch \
		"${FILESDIR}"/${P}-gcc46.patch \
		"${FILESDIR}"/${P}-libpng15.patch

	sed -i \
		-e 's:\.\./\.\./media:../media:g' \
		$(grep -rl '\.\./\.\./media' examples) \
		|| die 'sed failed'
}

src_compile() {
	tc-export CXX CC AR
	emake sharedlib staticlib || die "emake failed"
}

src_install() {
	cd ../..
	dolib.a lib/Linux/libIrrlicht.a || die
	dolib.so lib/Linux/libIrrlicht.so* || die
	insinto /usr/include/${PN}
	doins include/* || die
	dodoc changes.txt readme.txt
	if use doc ; then
		insinto /usr/share/doc/${PF}
		doins -r examples media || die
	fi
}
