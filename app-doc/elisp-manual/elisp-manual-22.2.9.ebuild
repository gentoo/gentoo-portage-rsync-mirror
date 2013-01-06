# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/elisp-manual/elisp-manual-22.2.9.ebuild,v 1.7 2012/07/29 17:34:55 armin76 Exp $

inherit eutils

MY_P=${PN}-${PV/./-}
DESCRIPTION="The GNU Emacs Lisp Reference Manual"
HOMEPAGE="http://www.gnu.org/software/emacs/manual/"
# Taken from lispref/ of emacs-22.3
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"

LICENSE="FDL-1.2"
SLOT="22"
KEYWORDS="amd64 ppc x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-direntry.patch"
}

src_compile() {
	makeinfo elisp.texi || die "makeinfo failed"
}

src_install() {
	doinfo elisp22.info* || die "doinfo failed"
	dodoc ChangeLog README
}
