# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/elisp-manual/elisp-manual-23.4.ebuild,v 1.8 2013/04/01 23:27:09 ulm Exp $

EAPI=5

inherit eutils

DESCRIPTION="The GNU Emacs Lisp Reference Manual"
HOMEPAGE="http://www.gnu.org/software/emacs/manual/"
# taken from doc/lispref/ of emacs-${PV}
SRC_URI="mirror://gentoo/${P}.tar.xz
	mirror://gentoo/${P}-patches-1.tar.xz"

LICENSE="FDL-1.3+"
SLOT="23"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"

DEPEND="app-arch/xz-utils
	sys-apps/texinfo"

S="${WORKDIR}/lispref"

src_prepare() {
	EPATCH_SUFFIX=patch epatch
}

src_compile() {
	makeinfo elisp.texi || die
}

src_install() {
	doinfo elisp${SLOT}.info*
	dodoc ChangeLog README
}
