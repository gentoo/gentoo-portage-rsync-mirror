# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/magit/magit-1.2.0.ebuild,v 1.1 2012/11/26 11:31:15 ulm Exp $

EAPI=5

inherit elisp

DESCRIPTION="An Emacs mode for GIT"
HOMEPAGE="http://magit.github.com/magit/"
SRC_URI="http://github.com/downloads/magit/magit/${P}.tar.gz"

LICENSE="GPL-3+ FDL-1.2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="contrib"

SITEFILE="50${PN}-gentoo.el"

src_compile() {
	emake core docs
	use contrib && emake contrib
	rm 50magit.el magit-pkg.el || die
}

src_install() {
	elisp-install ${PN} *.{el,elc} || die
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	doinfo magit.info
	dodoc README.md

	if use contrib; then
		elisp-install ${PN} contrib/*.{el,elc} || die
		dobin contrib/magit
	fi
}
