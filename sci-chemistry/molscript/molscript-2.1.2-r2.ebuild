# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/molscript/molscript-2.1.2-r2.ebuild,v 1.2 2015/02/17 12:02:53 jlec Exp $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="Display molecular 3D structures, such as proteins, in both schematic and detailed representations"
HOMEPAGE="http://www.avatar.se/molscript/"
SRC_URI="${P}.tar.gz"

LICENSE="glut molscript"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="
	virtual/jpeg
	media-libs/libpng
	media-libs/gd:=
	media-libs/freeglut
	|| (
		x11-libs/libXmu
		x11-libs/libXext
		x11-libs/libX11
		)"
RDEPEND="${DEPEND}"

RESTRICT="fetch"

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
	cp "${FILESDIR}"/glutbitmap.h "${S}"/clib/ || die

	# Stop an incredibly hacky include
	sed \
		-e 's:<../lib/glut/glutbitmap.h>:"glutbitmap.h":g' \
		-i "${S}"/clib/ogl_bitmap_character.c || die
}

src_compile() {
	# Prefix of programs it links with
	export FREEWAREDIR="${EPREFIX}/usr"

	ln -s Makefile.complete Makefile || die

	emake \
		CC="$(tc-getCC)" \
		COPT="${CFLAGS}"
}

src_install() {
	dobin molscript molauto
	dohtml "${S}"/doc/*.html
}
