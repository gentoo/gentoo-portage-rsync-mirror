# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/php-mode/php-mode-1.5.0.ebuild,v 1.6 2009/11/24 21:09:12 fauli Exp $

inherit elisp

DESCRIPTION="GNU Emacs major mode for editing PHP code"
HOMEPAGE="http://php-mode.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3 FDL-1.2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

SITEFILE=51${PN}-gentoo.el
DOCS="ChangeLog"

src_compile() {
	elisp_src_compile
	makeinfo ${PN}.texi || die "makeinfo failed"
}

src_install() {
	elisp_src_install
	doinfo ${PN}.info* || die "doinfo failed"
}
