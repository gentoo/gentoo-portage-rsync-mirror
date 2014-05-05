# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/magit/magit-1.2.0.ebuild,v 1.3 2014/05/05 07:21:06 graaff Exp $

EAPI=5

inherit elisp

DESCRIPTION="An Emacs mode for GIT"
HOMEPAGE="http://magit.github.io/"
SRC_URI="http://github.com/downloads/magit/magit/${P}.tar.gz"

LICENSE="GPL-3+ FDL-1.2+"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="contrib"

SITEFILE="50${PN}-gentoo.el"

RESTRICT="test"

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
