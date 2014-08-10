# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/stumpwm/stumpwm-0.9.7.ebuild,v 1.3 2014/08/10 20:00:16 slyfox Exp $

EAPI="2"

inherit common-lisp eutils

DESCRIPTION="Stumpwm is a tiling, keyboard driven X11 Window Manager written entirely in Common Lisp"
HOMEPAGE="http://www.nongnu.org/stumpwm/index.html"
SRC_URI="http://download.savannah.nongnu.org/releases/stumpwm/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="sbcl clisp emacs doc"

CLPACKAGE="stumpwm"

DEPEND="dev-lisp/common-lisp-controller
	virtual/commonlisp
	dev-lisp/cl-ppcre
	doc? ( sys-apps/texinfo )"

# If clisp is selected, we need at least dev-lisp/clisp-2.38-r2

RDEPEND="${DEPEND}
	emacs? ( app-emacs/slime )
	!clisp? ( !sbcl? ( !amd64? ( dev-lisp/cmucl ) ) )
	clisp? ( >=dev-lisp/clisp-2.38-r2[X,-new-clx] )
	sbcl?  ( dev-lisp/sbcl dev-lisp/cl-clx )"

src_configure() {
	sed "s,@PACKAGE_VERSION@,$PV,g" version.lisp.in > version.lisp
}

src_compile() {
	use doc && makeinfo stumpwm.texi.in
}

src_install() {
	common-lisp-install *.lisp stumpwm.asd
	common-lisp-system-symlink
	dodoc README NEWS ChangeLog "${FILESDIR}/README.Gentoo" || die
	use doc && doinfo stumpwm.info
}

pkg_postinst() {
	common-lisp_pkg_postinst
	cat "${FILESDIR}/README.Gentoo"
}
