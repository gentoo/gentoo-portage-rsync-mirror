# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/ode/ode-0.12.ebuild,v 1.6 2012/12/08 12:32:25 ago Exp $

EAPI=2
DESCRIPTION="Open Dynamics Engine SDK"
HOMEPAGE="http://ode.org/"
SRC_URI="mirror://sourceforge/opende/${P}.tar.bz2"

LICENSE="|| ( LGPL-2.1 BSD )"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug doc double-precision examples gyroscopic static-libs"

RDEPEND="examples? (
		virtual/opengl
	)"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_prepare() {
	sed -i \
		-e "s:\$.*/drawstuff/textures:/usr/share/doc/${PF}/examples:" \
		drawstuff/src/Makefile.in \
		ode/demo/Makefile.in \
		|| die "sed Makefile.in failed"
}

src_configure() {
	# use bash (bug #335760)
	CONFIG_SHELL=/bin/bash \
	econf \
		--disable-dependency-tracking \
		--enable-shared \
		$(use_enable static-libs static) \
		$(use_enable debug asserts) \
		$(use_enable double-precision) \
		$(use_enable examples demos) \
		$(use_enable gyroscopic) \
		$(use_with examples drawstuff X11)
}

src_compile() {
	emake || die "emake failed"
	if use doc ; then
		cd ode/doc
		doxygen Doxyfile || die "doxygen failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc CHANGELOG.txt README.txt
	if ! use static-libs ; then
		find "${D}" -type f -name '*.la' -exec rm {} + \
			|| die "la removal failed"
	fi
	if use doc ; then
		dohtml docs/* || die "dohtml failed"
	fi
	if use examples; then
		cd ode/demo
		exeinto /usr/share/doc/${PF}/examples
		local f
		for f in *.c* ; do
			doexe .libs/${f%.*} || die "doexe ${f%.*} failed"
		done
		cd ../..
		doexe drawstuff/dstest/dstest
		insinto /usr/share/doc/${PF}/examples
		doins ode/demo/*.{c,cpp,h} \
			drawstuff/textures/*.ppm \
			drawstuff/dstest/dstest.cpp \
			drawstuff/src/{drawstuff.cpp,internal.h,x11.cpp} \
			|| die "doins failed"
	fi
}
