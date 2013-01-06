# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/company-mode/company-mode-0.5.ebuild,v 1.2 2010/10/09 16:25:16 ulm Exp $

EAPI=2
NEED_EMACS=22

inherit elisp

DESCRIPTION="In-buffer completion front-end"
HOMEPAGE="http://nschum.de/src/emacs/company-mode/"
SRC_URI="http://nschum.de/src/emacs/${PN}/company-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ropemacs +semantic"

# Note: company-mode supports many backends, and we refrain from including
# them all in RDEPEND. Only depend on things that are needed at build time.
DEPEND="|| ( app-emacs/nxml-mode >=virtual/emacs-23 )
	ropemacs? ( app-emacs/pymacs )
	semantic? ( virtual/emacs-cedet )"
RDEPEND="${DEPEND}
	ropemacs? ( dev-python/ropemacs )"

S="${WORKDIR}"
SITEFILE="50${PN}-gentoo.el"

src_prepare() {
	# Disable backends that require extra dependencies, unless they are
	# selected by the respective USE flag

	elog "Removing pysmell backend"
	rm company-pysmell.el || die

	if ! use ropemacs; then
		elog "Removing ropemacs backend, as requested by USE=-ropemacs"
		rm company-ropemacs.el || die
	fi

	if ! use semantic; then
		elog "Removing semantic backend, as requested by USE=-semantic"
		rm company-semantic.el || die
	fi
}
