# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/sphinxbase/sphinxbase-0.7.ebuild,v 1.4 2012/12/14 11:11:58 ulm Exp $

EAPI=3
PYTHON_DEPEND="python? 2:2.6"
RESTRICT_PYTHON_ABIS="3* 2.7-pypy-*"
SUPPORT_PYTHON_ABIS="1"

inherit autotools-utils python

DESCRIPTION="Support library required by the Sphinx Speech Recognition Engine"
HOMEPAGE="http://cmusphinx.sourceforge.net/"
SRC_URI="mirror://sourceforge/cmusphinx/${P}.tar.gz"

LICENSE="BSD-2 HPND MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc lapack python static-libs"

RDEPEND="lapack? ( virtual/lapack )"
DEPEND="${RDEPEND}
		doc? ( >=app-doc/doxygen-1.4.7 )"

# Due to generated Python setup.py.
AUTOTOOLS_IN_SOURCE_BUILD=1

src_configure() {
	local myeconfargs=(
		$( use_with lapack )
		# python modules are built through distutils
		# so disable the ugly wrapper
		--without-python
	)

	autotools-utils_src_configure
}

src_compile() {
	autotools-utils_src_compile

	if use python; then
		python_copy_sources python

		building() {
			emake PYTHON="$(PYTHON)" PYTHON_INCLUDEDIR="$(python_get_includedir)" PYTHON_LIBDIR="$(python_get_libdir)"
		}

		python_execute_function -s --source-dir python building
	fi
}

src_install() {
	autotools-utils_src_install

	if use python; then
		python_execute_function -s --source-dir python -d
	fi

	if use doc; then
		dohtml doc/html/*
	fi
}
