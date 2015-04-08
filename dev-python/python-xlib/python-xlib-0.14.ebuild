# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-xlib/python-xlib-0.14.ebuild,v 1.9 2011/04/16 18:49:22 armin76 Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="A fully functional X client library for Python, written in Python"
HOMEPAGE="http://python-xlib.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ppc ~ppc64 x86"
IUSE="doc"

DEPEND="doc? (
		virtual/latex-base
		>=sys-apps/texinfo-4.8-r2
	)"
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

PYTHON_MODNAME="Xlib"

src_compile() {
	distutils_src_compile

	if use doc; then
		cd doc
		einfo "Generation of documentation"
		VARTEXFONTS="${T}"/fonts emake || die "Generation of documentation failed"
	fi
}

src_test() {
	cd test
	testing() {
		local return_status="0" test
		for test in *.py; do
			echo "Running ${test}..."
			PYTHONPATH="../build-${PYTHON_ABI}/lib" "$(PYTHON)" "${test}" || return_status="1"
		done
		return "${return_status}"
	}
	python_execute_function testing
}

src_install () {
	distutils_src_install

	if use doc; then
		dohtml -r doc/html/
		dodoc doc/ps/python-xlib.ps
	fi
}
