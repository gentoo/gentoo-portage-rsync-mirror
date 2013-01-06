# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/filladapt/filladapt-2.12-r1.ebuild,v 1.4 2008/06/14 23:26:02 ulm Exp $

inherit elisp

DESCRIPTION="Filladapt enhances the behavior of Emacs' fill functions"
HOMEPAGE="http://www.wonderworks.com/"
SRC_URI="mirror://gentoo/${P}.el.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

SITEFILE=51${PN}-gentoo.el

pkg_postinst() {
	elisp-site-regen
	elog "Filladapt is no longer enabled as a site default. Add the following"
	elog "lines to your ~/.emacs file to enable adaptive fill by default:"
	elog "  (require 'filladapt)"
	elog "  (setq-default filladapt-mode t)"
}
