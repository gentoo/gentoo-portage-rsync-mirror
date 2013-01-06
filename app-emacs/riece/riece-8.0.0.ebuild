# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/riece/riece-8.0.0.ebuild,v 1.6 2012/09/30 18:07:22 armin76 Exp $

EAPI=4

inherit elisp

DESCRIPTION="A redesign of Liece IRC client"
HOMEPAGE="http://www.nongnu.org/riece/"
SRC_URI="http://download.savannah.gnu.org/releases/riece/${P}.tar.gz"

LICENSE="GPL-3 FDL-1.1"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="linguas_ja"
RESTRICT="test"

SITEFILE="50${PN}-gentoo.el"

src_configure() {
	econf --with-lispdir="${SITELISP}"
}

src_compile() {
	default
}

src_install () {
	einstall lispdir="${D}/${SITELISP}"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die

	dodoc AUTHORS NEWS README doc/HACKING lisp/ChangeLog*

	if use linguas_ja; then
		dodoc NEWS.ja README.ja doc/HACKING.ja
	else
		rm -f "${D}"/usr/share/info/riece-ja.info*
	fi
}
