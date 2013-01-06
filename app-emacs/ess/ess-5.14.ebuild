# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ess/ess-5.14.ebuild,v 1.6 2012/09/29 09:39:33 ulm Exp $

EAPI=4

inherit elisp

DESCRIPTION="Emacs Speaks Statistics"
HOMEPAGE="http://ess.r-project.org/"
SRC_URI="http://ess.r-project.org/downloads/ess/${P}.tgz"

LICENSE="GPL-2+ GPL-3+ Texinfo-manual"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

DEPEND="app-text/texi2html
	virtual/latex-base"
RDEPEND=""

SITEFILE="50${PN}-gentoo.el"

src_compile() {
	default
}

src_install() {
	emake PREFIX="${ED}/usr" \
		INFODIR="${ED}/usr/share/info" \
		LISPDIR="${ED}${SITELISP}/ess" \
		DOCDIR="${ED}/usr/share/doc/${PF}" \
		install

	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die

	# Most documentation is installed by the package's build system.
	rm -f "${ED}${SITELISP}/${PN}/ChangeLog"
	dodoc ChangeLog *NEWS doc/{TODO,ess-intro.pdf}
	newdoc lisp/ChangeLog ChangeLog-lisp
}

pkg_postinst() {
	elisp-site-regen
	elog "Please see /usr/share/doc/${PF} for the complete documentation."
	elog "Usage hints are in ${SITELISP}/${PN}/ess-site.el ."
}
