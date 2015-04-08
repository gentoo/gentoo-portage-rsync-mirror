# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/pymacs/pymacs-0.25-r1.ebuild,v 1.10 2015/03/31 06:10:22 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit elisp distutils-r1 vcs-snapshot

DESCRIPTION="A tool that allows both-side communication beetween Python and Emacs Lisp"
HOMEPAGE="http://pymacs.progiciels-bpi.ca/"
SRC_URI="https://github.com/pinard/Pymacs/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm hppa ia64 ppc ppc64 ~s390 ~sh x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="doc"

DEPEND="doc? ( >=dev-python/docutils-0.7
			virtual/latex-base )"
RDEPEND=""

DISTUTILS_IN_SOURCE_BUILD=1
SITEFILE="50${PN}-gentoo.el"

# called by distutils-r1 for every python implementation
python_configure() {
	# pre-process the files but don't run distutils
	emake PYSETUP=: PYTHON=${EPYTHON}
}

# called once
python_compile_all() {
	elisp_src_compile
	if use doc; then
		VARTEXFONTS="${T}"/fonts emake RST2LATEX=rst2latex.py pymacs.pdf
	fi
}

python_install_all() {
	elisp_src_install
	distutils-r1_python_install_all
	dodoc pymacs.rst
	use doc && dodoc pymacs.pdf
}
