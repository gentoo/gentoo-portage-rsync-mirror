# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/metakit/metakit-2.4.9.7-r1.ebuild,v 1.5 2012/09/23 08:38:53 phajdan.jr Exp $

EAPI=4

PYTHON_DEPEND="python? 2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-*"

inherit eutils flag-o-matic multilib python toolchain-funcs

DESCRIPTION="Embedded database library"
HOMEPAGE="http://www.equi4.com/metakit/"
SRC_URI="http://www.equi4.com/pub/mk/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="python static tcl"

DEPEND="tcl? ( dev-lang/tcl )"
RDEPEND="${DEPEND}"

RESTRICT="test"

pkg_setup() {
	use python && python_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}/${P}-linking.patch"
}

src_configure() {
	local myconf mycxxflags
	use tcl && myconf+=" --with-tcl=${EPREFIX}/usr/include,${EPREFIX}/usr/$(get_libdir)"
	use static && myconf+=" --disable-shared"
	use static || append-cxxflags -fPIC

	CXXFLAGS="${CXXFLAGS} ${mycxxflags}" unix/configure \
		${myconf} \
		--host=${CHOST} \
		--prefix="${EPREFIX}/usr" \
		--libdir="${EPREFIX}/usr/$(get_libdir)" \
		--infodir="${EPREFIX}/usr/share/info" \
		--mandir="${EPREFIX}/usr/share/man"
}

src_compile() {
	emake SHLIB_LD="$(tc-getCXX) -shared -Wl,-soname,libmk4.so.2.4"

	if use python; then
		python_copy_sources

		building() {
			emake \
				SHLIB_LD="$(tc-getCXX) -shared" \
				pyincludedir="$(python_get_includedir)" \
				PYTHON_LIB="$(python_get_library)" \
				python
		}
		python_execute_function -s building
	fi
}

src_install () {
	default

	mv "${ED}"//usr/$(get_libdir)/libmk4.so{,.2.4}
	dosym libmk4.so.2.4 /usr/$(get_libdir)/libmk4.so.2
	dosym libmk4.so.2.4 /usr/$(get_libdir)/libmk4.so

	if use python; then
		installation() {
			dodir "$(python_get_sitedir)" || return 1
			emake \
				DESTDIR="${D}" \
				pylibdir="$(python_get_sitedir)" \
				install-python
		}
		python_execute_function -s installation
	fi

	dohtml Metakit.html
	dohtml -a html,gif,png,jpg -r doc/*
}

pkg_postinst() {
	if use python; then
		python_mod_optimize metakit.py
	fi
}

pkg_postrm() {
	if use python; then
		python_mod_cleanup metakit.py
	fi
}
