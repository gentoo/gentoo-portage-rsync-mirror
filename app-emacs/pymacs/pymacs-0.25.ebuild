# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/pymacs/pymacs-0.25.ebuild,v 1.1 2013/02/17 13:54:49 ulm Exp $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7} )

inherit distutils-r1 elisp vcs-snapshot

DESCRIPTION="A tool that allows both-side communication beetween Python and Emacs Lisp"
HOMEPAGE="http://pymacs.progiciels-bpi.ca/"
SRC_URI="https://github.com/pinard/Pymacs/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="doc"

DEPEND="doc? ( >=dev-python/docutils-0.7
			virtual/latex-base )"
RDEPEND=""

SITEFILE="50${PN}-gentoo.el"

python_configure_all() {
	# pre-process the files but don't run distutils
	emake PYSETUP=:
}

src_configure() {
	distutils-r1_src_configure
}

src_compile() {
	distutils-r1_src_compile
	elisp-compile pymacs.el || die
	if use doc; then
		VARTEXFONTS="${T}"/fonts emake RST2LATEX=rst2latex.py pymacs.pdf
	fi
}

src_install() {
	distutils-r1_src_install
	elisp_src_install
	dodoc pymacs.rst
	use doc && dodoc pymacs.pdf
}
