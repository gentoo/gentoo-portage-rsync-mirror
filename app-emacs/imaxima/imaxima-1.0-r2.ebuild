# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/imaxima/imaxima-1.0-r2.ebuild,v 1.7 2013/01/02 21:03:31 ulm Exp $

EAPI=3

inherit elisp

MY_P="${PN}-imath-${PV/_}"
DESCRIPTION="Imaxima enables graphical output in Maxima sessions with emacs"
HOMEPAGE="http://sites.google.com/site/imaximaimath/"
SRC_URI="http://members3.jcom.home.ne.jp/imaxima/Site/Download_and_Install_files/${MY_P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="examples"

DEPEND=""
RDEPEND="virtual/latex-base
	app-text/ghostscript-gpl
	dev-tex/mh
	<sci-mathematics/maxima-5.29"

S="${WORKDIR}/${MY_P}"
SITEFILE="50${PN}-gentoo.el"

src_prepare() {
	# Remove broken Info file (will be recreated)
	rm imaxima.info
}

src_configure() {
	econf --with-lispdir="${EPREFIX}${SITELISP}/${PN}"
}

# This is NOT redundant, elisp.eclass redefines src_compile
src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	dodoc ChangeLog NEWS README || die

	if use examples; then
		docinto imath-example
		dodoc imath-example/*.txt || die
		dohtml -r imath-example/. || die
	fi
}
