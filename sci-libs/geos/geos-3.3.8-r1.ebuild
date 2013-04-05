# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/geos/geos-3.3.8-r1.ebuild,v 1.6 2013/04/05 20:31:25 ago Exp $

EAPI=4

PYTHON_DEPEND="python? 2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-*"
inherit autotools eutils python

DESCRIPTION="Geometry engine library for Geographic Information Systems"
HOMEPAGE="http://trac.osgeo.org/geos/"
SRC_URI="http://download.osgeo.org/geos/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm ppc ppc64 ~x86 ~x64-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris"
IUSE="doc php python ruby static-libs"

RDEPEND="
	php? ( >=dev-lang/php-5.3[-threads] )
	ruby? ( dev-lang/ruby )
"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	php? ( dev-lang/swig )
	python? ( dev-lang/swig )
	ruby? ( dev-lang/swig )
"

pkg_setup() {
	use python && python_pkg_setup
}

src_prepare() {
	epatch \
		"${FILESDIR}"/3.2.0-python.patch \
		"${FILESDIR}"/3.2.0-darwin.patch \
		"${FILESDIR}"/3.3.2-solaris-isnan.patch
	eautoreconf
	echo "#!${EPREFIX}/bin/bash" > py-compile
}

src_configure() {
	econf \
		$(use_enable python) \
		$(use_enable ruby) \
		$(use_enable php) \
		$(use_enable static-libs static)
}

src_compile() {
	emake

	if use python; then
		emake -C swig/python clean
		python_copy_sources swig/python
		building() {
			emake \
				PYTHON_CPPFLAGS="-I${EPREFIX}$(python_get_includedir)" \
				PYTHON_LDFLAGS="$(python_get_library -l)" \
				SWIG_PYTHON_CPPFLAGS="-I${EPREFIX}$(python_get_includedir)" \
				pyexecdir="${EPREFIX}$(python_get_sitedir)" \
				pythondir="${EPREFIX}$(python_get_sitedir)"
		}
		python_execute_function -s --source-dir swig/python building
	fi

	use doc && emake -C "${S}/doc" doxygen-html
}

src_install() {
	default

	if use python; then
		installation() {
			emake \
				DESTDIR="${D}" \
				pyexecdir="${EPREFIX}$(python_get_sitedir)" \
				pythondir="${EPREFIX}$(python_get_sitedir)" \
				install
		}
		python_execute_function -s --source-dir swig/python installation
		python_clean_installation_image
	fi

	use doc && dohtml -r doc/doxygen_docs/html/*

	find "${ED}" -name '*.la' -exec rm -f {} +
}

pkg_postinst() {
	use python && python_mod_optimize geos/geos.py
}

pkg_postrm() {
	use python && python_mod_cleanup geos/geos.py
}
