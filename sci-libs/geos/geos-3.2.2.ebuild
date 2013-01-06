# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/geos/geos-3.2.2.ebuild,v 1.12 2012/02/20 15:27:40 patrick Exp $

EAPI="3"

PYTHON_DEPEND="python? 2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-*"

inherit autotools eutils python

DESCRIPTION="Geometry engine library for Geographic Information Systems"
HOMEPAGE="http://trac.osgeo.org/geos/"
SRC_URI="http://download.osgeo.org/geos/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x64-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris"
IUSE="doc python ruby static-libs"

RDEPEND="ruby? ( dev-lang/ruby:1.8 )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	ruby?  ( dev-lang/swig )
	python? ( dev-lang/swig )"

pkg_setup() {
	use python && python_pkg_setup
}

src_prepare() {
	epatch \
		"${FILESDIR}"/3.2.0-multipy.patch \
		"${FILESDIR}"/3.2.0-swig2.0.patch \
		"${FILESDIR}"/3.2.0-python.patch \
		"${FILESDIR}"/3.2.0-darwin.patch \
		"${FILESDIR}"/${PV}-disable_static_modules.patch \
		"${FILESDIR}"/${PV}-gcc46.patch
	eautoreconf
	echo "#!${EPREFIX}/bin/bash" > py-compile
}

src_configure() {
	econf \
		$(use_enable python) \
		$(use_enable ruby) \
		$(use_enable static-libs static)
}

src_compile() {
	emake || die "emake failed"
	if use python; then
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
	if use doc; then
		cd "${S}/doc"
		emake doxygen-html || die "doc generation failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	if use python; then
		python_copy_sources swig/python
		installation() {
			emake \
			DESTDIR="${D}" \
			pythondir="${EPREFIX}$(python_get_sitedir)" \
			pyexecdir="${EPREFIX}$(python_get_sitedir)" \
			install
		}
		python_execute_function -s --source-dir swig/python installation
		python_clean_installation_image
	fi

	dodoc AUTHORS NEWS README TODO || die
	if use doc; then
		cd "${S}/doc"
		dohtml -r doxygen_docs/html/* || die
	fi

	find "${ED}" -name '*.la' -exec rm -f {} +
}

pkg_postinst() {
	use python && python_mod_optimize geos/geos.py
}

pkg_postrm() {
	use python && python_mod_cleanup geos/geos.py
}
