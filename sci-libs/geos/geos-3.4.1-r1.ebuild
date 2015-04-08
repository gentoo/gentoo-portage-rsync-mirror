# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/geos/geos-3.4.1-r1.ebuild,v 1.3 2013/12/22 13:47:54 ago Exp $

EAPI="5"

PYTHON_COMPAT=( python2_{6,7} )
inherit autotools eutils python-single-r1 python-utils-r1

DESCRIPTION="Geometry engine library for Geographic Information Systems"
HOMEPAGE="http://trac.osgeo.org/geos/"
SRC_URI="http://download.osgeo.org/geos/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm ppc ppc64 x86 ~x64-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris"
IUSE="doc php python ruby static-libs"

RDEPEND="
	php? ( >=dev-lang/php-5.3[-threads] )
	ruby? ( dev-lang/ruby )
"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	php? ( dev-lang/swig )
	python? ( dev-lang/swig ${PYTHON_DEPS} )
	ruby? ( dev-lang/swig )
"

src_prepare() {
	epatch "${FILESDIR}"/3.4.1-solaris-isnan.patch
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

	use doc && emake -C "${S}/doc" doxygen-html
}

src_install() {
	emake DESTDIR="${D}" install

	# https://bugs.gentoo.org/show_bug.cgi?id=487068
	insinto /usr/include/geos
	doins include/geos/platform.h

	use doc && dohtml -r doc/doxygen_docs/html/*
	use python && python_optimize "${D}$(python_get_sitedir)"/geos/

	find "${ED}" -name '*.la' -exec rm -f {} +
}
