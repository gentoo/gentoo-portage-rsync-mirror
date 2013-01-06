# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tcl3d/tcl3d-0.4.0.ebuild,v 1.1 2009/05/10 13:17:04 mescalinum Exp $

EAPI="2"

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Tcl bindings to OpenGL and other 3D libraries"
HOMEPAGE="http://www.tcl3d.org"
SRC_URI="http://www.tcl3d.org/download/${P}.distrib/${PN}-src-${PV}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

RDEPEND="virtual/opengl
	dev-lang/tk
	dev-lang/tcl
	media-libs/libsdl
	media-libs/ftgl
	dev-games/ode"
DEPEND="${RDEPEND}
	>=dev-lang/swig-1.3.19"

S="${WORKDIR}/${PN}"

src_prepare() {
	TCL_VERSION=( $(echo 'puts [info tclversion]' | tclsh | tr '.' ' ') )
	einfo "Configuring for Tcl ${TCL_VERSION[0]}.${TCL_VERSION[1]}"
	sed -i \
		-e 's:^\(TCLMAJOR\) *=\(.*\)$:\1 = '${TCL_VERSION[0]}':' \
		-e 's:^\(TCLMINOR\) *=\(.*\)$:\1 = '${TCL_VERSION[1]}':' \
		config_Linux*

	# fix libSDL link
	sed -i \
		-e 's:-lSDL-1\.2:-lSDL:g' \
		tcl3dSDL/Makefile
}

src_compile() {
	append-flags -mieee-fp -ffloat-store -fPIC
	if use debug; then
		append-flags -g
		filter-flags -O?
	else
		append-flags -DNDEBUG
	fi
	gmake INSTDIR="/usr" OPT="${CFLAGS}" CC="$(tc-getCC) -c" \
		CXX="$(tc-getCXX) -c" LD="$(tc-getLD)" \
		WRAP_FTGL=1 WRAP_SDL=1 WRAP_GL2PS=0 WRAP_ODE=1 || die "gmake failed"
}

src_install() {
	gmake INSTDIR="${D}/usr" DESTDIR="${D}" install || die "gmake install failed"
}
