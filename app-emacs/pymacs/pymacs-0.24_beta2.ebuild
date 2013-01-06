# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/pymacs/pymacs-0.24_beta2.ebuild,v 1.1 2011/10/07 20:58:00 ulm Exp $

EAPI=3
SUPPORT_PYTHON_ABIS=1

inherit distutils elisp

DESCRIPTION="A tool that allows both-side communication beetween Python and Emacs Lisp"
HOMEPAGE="http://pymacs.progiciels-bpi.ca/"
# taken from https://github.com/pinard/Pymacs/tarball/v0.24-beta2
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="doc"

DEPEND="doc? ( >=dev-python/docutils-0.7
			virtual/latex-base )"
RDEPEND=""

SITEFILE="50${PN}-gentoo.el"

src_unpack() {
	unpack ${A}
	mv pinard-Pymacs-* "${S}" || die
}

src_compile() {
	emake || die
	elisp-compile pymacs.el || die
	if use doc; then
		VARTEXFONTS="${T}"/fonts \
			emake RST2LATEX=rst2latex.py pymacs.pdf || die
	fi
}

src_install() {
	elisp_src_install
	distutils_src_install
	dodoc THANKS pymacs.rst || die
	if use doc; then
		dodoc pymacs.pdf || die
	fi
}
