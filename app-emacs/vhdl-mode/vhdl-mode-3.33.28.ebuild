# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/vhdl-mode/vhdl-mode-3.33.28.ebuild,v 1.4 2011/01/08 00:53:13 ranger Exp $

EAPI=3

inherit elisp

DESCRIPTION="VHDL-mode for Emacs"
HOMEPAGE="http://www.iis.ee.ethz.ch/~zimmi/emacs/vhdl-mode.html"
SRC_URI="http://www.iis.ee.ethz.ch/~zimmi/emacs/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

ELISP_PATCHES="${PN}-info-dir-gentoo.patch"
SITEFILE="50${PN}-gentoo.el"
DOCS="ChangeLog README"

src_prepare() {
	elisp_src_prepare
	rm site-start.* || die
}

src_install() {
	elisp_src_install
	doinfo vhdl-mode.info || die
}
