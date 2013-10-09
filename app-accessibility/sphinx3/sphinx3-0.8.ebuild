# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/sphinx3/sphinx3-0.8.ebuild,v 1.6 2013/10/09 02:03:56 teiresias Exp $

EAPI=3
PYTHON_DEPEND="python? 2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit autotools-utils prefix python eutils

DESCRIPTION="CMU Speech Recognition engine"
HOMEPAGE="http://cmusphinx.sourceforge.net/"
SRC_URI="mirror://sourceforge/cmusphinx/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc python static-libs"

DEPEND=">=app-accessibility/sphinxbase-0.7[static-libs?,python?]"
RDEPEND="${DEPEND}"

# Due to generated Python setup.py.
AUTOTOOLS_IN_SOURCE_BUILD=1

src_prepare() {
	epatch "${FILESDIR}/${P}_heap_fix.patch" \
		"${FILESDIR}/${P}-libutil.patch"
	eprefixify 'python/setup.py'
}

src_compile() {
	autotools-utils_src_compile

	if use python; then
		python_copy_sources python

		building() {
			"$(PYTHON)" setup.py build
		}

		python_execute_function -s --source-dir python building
	fi
}

src_install() {
	local DOCS=( AUTHORS ChangeLog NEWS README )
	autotools-utils_src_install

	if use doc; then
		cd doc
		dohtml -r -x CVS s3* s3 *.html
	fi

	if use python; then
		installing() {
			"$(PYTHON)" setup.py install \
				--install-lib="${D}/$(python_get_sitedir)"
		}

		python_execute_function -s --source-dir python installing
	fi
}
