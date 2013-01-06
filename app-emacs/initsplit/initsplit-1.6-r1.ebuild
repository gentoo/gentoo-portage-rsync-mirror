# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/initsplit/initsplit-1.6-r1.ebuild,v 1.2 2007/12/01 11:53:24 opfer Exp $

inherit elisp

DESCRIPTION="Split customizations into different files"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki?InitSplit"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

SITEFILE=51${PN}-gentoo.el

pkg_postinst() {
	elisp-site-regen
	elog "Initsplit is no longer enabled as a site default. Add the following"
	elog "line to your ~/.emacs file to enable configuration file splitting:"
	elog "  (add-hook 'write-file-hooks 'initsplit-split-user-init-file t)"
	elog ""
	elog "If you want configuration files byte-compiled, also add this line:"
	elog "  (add-hook 'after-save-hook 'initsplit-byte-compile-files t)"
}
