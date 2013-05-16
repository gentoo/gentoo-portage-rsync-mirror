# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/elisp-manual/elisp-manual-24.3.ebuild,v 1.5 2013/05/16 13:23:59 ago Exp $

EAPI=5

inherit eutils

DESCRIPTION="The GNU Emacs Lisp Reference Manual"
HOMEPAGE="http://www.gnu.org/software/emacs/manual/"
# taken from doc/lispref/ of emacs-${PV}
SRC_URI="mirror://gentoo/${P}.tar.xz"

LICENSE="FDL-1.3+"
SLOT="24"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"

DEPEND="app-arch/xz-utils
	sys-apps/texinfo"

S="${WORKDIR}/lispref"

src_prepare() {
	epatch "${FILESDIR}/${P}-direntry.patch"
	echo "@set EMACSVER ${PV}" >emacsver.texi || die
}

src_compile() {
	makeinfo elisp.texi || die
}

src_install() {
	doinfo elisp${SLOT}.info*
	dodoc ChangeLog README
}
