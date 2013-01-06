# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/neoengine/neoengine-0.8.2-r1.ebuild,v 1.5 2011/02/28 18:04:44 ssuominen Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="An open source, platform independent, 3D game engine written in C++"
HOMEPAGE="http://www.neoengine.org/"
SRC_URI="mirror://sourceforge/neoengine/${P}.tar.bz2"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="ppc x86"
IUSE="doc"

RDEPEND="virtual/opengl
	media-libs/alsa-lib
	media-libs/libpng
	virtual/jpeg"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

S=${WORKDIR}/neoengine

src_prepare() {
	epatch \
		"${FILESDIR}/${P}"-gcc41.patch \
		"${FILESDIR}/${P}"-gcc43.patch \
		"${FILESDIR}"/${P}-nolibs.patch \
		"${FILESDIR}"/${P}-gcc44.patch

	./setbuildtype.sh dynamic

	eautoreconf
	eautomake neodevopengl/Makefile
	eautomake neodevalsa/Makefile
}

src_configure() {
	econf \
		--disable-dependency-tracking
}

src_compile() {
	emake || die

	if use doc; then
		emake doc || die
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog* NEWS README
	use doc && dohtml -r *-api
}
