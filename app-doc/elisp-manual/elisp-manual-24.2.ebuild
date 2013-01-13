# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/elisp-manual/elisp-manual-24.2.ebuild,v 1.4 2013/01/13 11:35:47 ago Exp $

EAPI=4

inherit eutils

DESCRIPTION="The GNU Emacs Lisp Reference Manual"
HOMEPAGE="http://www.gnu.org/software/emacs/manual/"
# taken from doc/lispref/ of emacs-${PV}
SRC_URI="mirror://gentoo/${P}.tar.xz"

LICENSE="FDL-1.3"
SLOT="24"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"

DEPEND="app-arch/xz-utils"

S="${WORKDIR}/lispref"

src_prepare() {
	epatch "${FILESDIR}/${P}-direntry.patch"
	echo "@set EMACSVER ${PV}" >"${S}/emacsver.texi" || die
}

src_compile() {
	makeinfo elisp.texi || die "makeinfo failed"
}

src_install() {
	doinfo elisp${SLOT}.info*
	dodoc ChangeLog README
}
