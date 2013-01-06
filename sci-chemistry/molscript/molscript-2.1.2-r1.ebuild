# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/molscript/molscript-2.1.2-r1.ebuild,v 1.8 2011/08/09 08:25:28 ssuominen Exp $

EAPI="3"

inherit eutils toolchain-funcs

DESCRIPTION="Display molecular 3D structures, such as proteins, in both schematic and detailed representations"
HOMEPAGE="http://www.avatar.se/molscript/"
SRC_URI="${P}.tar.gz"

LICENSE="glut molscript"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux"
RESTRICT="fetch"
IUSE=""

DEPEND="
	virtual/jpeg
	media-libs/libpng
	media-libs/gd
	media-libs/freeglut
	|| (	x11-libs/libXmu
			x11-libs/libXext
			x11-libs/libX11	)"
RDEPEND="${DEPEND}"

pkg_nofetch() {
	elog "Please visit ${HOMEPAGE}"
	elog "and get ${A}."
	elog "Place it in ${DISTDIR}"
}

src_prepare() {
	epatch \
		"${FILESDIR}"/fix-makefile-shared.patch \
		"${FILESDIR}"/${PV}-ldflags.patch \
		"${FILESDIR}"/${PV}-prll.patch \
		"${FILESDIR}"/${PV}-libpng15.patch

	# Provide glutbitmap.h, because freeglut doesn't have it
	cp "${FILESDIR}"/glutbitmap.h "${S}"/clib/

	# Stop an incredibly hacky include
	sed -i -e 's:<../lib/glut/glutbitmap.h>:"glutbitmap.h":g' \
		"${S}"/clib/ogl_bitmap_character.c || die
}

src_compile() {
	# Prefix of programs it links with
	export FREEWAREDIR="${EPREFIX}/usr"

	ln -s Makefile.complete Makefile

	emake \
		CC="$(tc-getCC)" \
		COPT="${CFLAGS}" \
		|| die "emake failed"
}

src_install() {
	dobin molscript molauto || die
	dohtml "${S}"/doc/*.html || die
}
