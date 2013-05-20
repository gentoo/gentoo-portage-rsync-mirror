# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/emacs-updater/emacs-updater-1.13.ebuild,v 1.11 2013/05/20 18:03:05 ago Exp $

EAPI=5

DESCRIPTION="Rebuild Emacs packages"
HOMEPAGE="http://www.gentoo.org/proj/en/lisp/emacs/"
SRC_URI="mirror://gentoo/${P}.tar.xz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 ~sh ~sparc x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE=""

DEPEND="app-arch/xz-utils"
RDEPEND=">=app-portage/portage-utils-0.3
	virtual/emacs"

src_prepare() {
	if [[ -n ${EPREFIX} ]]; then
		sed -i -e "1s:/:${EPREFIX%/}/:" \
			-e "s:^\(EMACS\|SITELISP\)=:&${EPREFIX%/}:" \
			emacs-updater || die
	fi
}

src_install() {
	dosbin emacs-updater
	doman emacs-updater.8
}
