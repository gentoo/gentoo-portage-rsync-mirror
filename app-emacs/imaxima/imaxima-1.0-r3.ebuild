# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/imaxima/imaxima-1.0-r3.ebuild,v 1.3 2014/09/11 15:09:36 ulm Exp $

EAPI=5

inherit elisp

MY_P="${PN}-imath-${PV/_}"
DESCRIPTION="Imaxima enables graphical output in Maxima sessions with emacs"
HOMEPAGE="http://sites.google.com/site/imaximaimath/"
SRC_URI="https://sites.google.com/site/imaximaimath/download-and-install/${MY_P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="examples"

RDEPEND="virtual/latex-base
	app-text/ghostscript-gpl
	dev-tex/mh
	>=sci-mathematics/maxima-5.29"

S="${WORKDIR}/${MY_P}"
ELISP_PATCHES="${P}-1.03.patch ${P}-mlabel.patch"
ELISP_REMOVE="imaxima.info"		# remove broken Info file (will be recreated)
SITEFILE="50${PN}-gentoo.el"

src_configure() {
	econf \
		--with-lispdir="${EPREFIX}${SITELISP}/${PN}" \
		EMACS="${EMACS} ${EMACSFLAGS}"
}

src_compile() {
	default
}

src_install() {
	emake DESTDIR="${D}" install
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	dodoc ChangeLog NEWS README

	if use examples; then
		docinto imath-example
		dodoc imath-example/*.txt
		dohtml -r imath-example/.
	fi
}
