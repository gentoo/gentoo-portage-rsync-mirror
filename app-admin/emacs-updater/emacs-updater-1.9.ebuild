# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/emacs-updater/emacs-updater-1.9.ebuild,v 1.10 2012/10/11 16:13:22 ulm Exp $

EAPI=4

DESCRIPTION="Rebuild Emacs packages"
HOMEPAGE="http://www.gentoo.org/proj/en/lisp/emacs/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

RDEPEND="!<=app-admin/eselect-emacs-1.5
	>=app-portage/portage-utils-0.1.28
	virtual/emacs"

src_prepare() {
	if [ -n "${EPREFIX}" ]; then
		sed -i -e "1s:/:${EPREFIX%/}/:" \
			-e "s:^\(EMACS\|SITELISP\)=:&${EPREFIX%/}:" \
			emacs-updater || die
	fi
}

src_install() {
	dosbin emacs-updater
	doman emacs-updater.8
}
