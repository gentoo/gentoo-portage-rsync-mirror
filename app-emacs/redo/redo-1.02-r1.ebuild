# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/redo/redo-1.02-r1.ebuild,v 1.6 2007/07/05 23:08:22 angelos Exp $

inherit elisp

DESCRIPTION="Redo/undo system for Emacs"
HOMEPAGE="http://www.wonderworks.com/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 x86"
IUSE=""

SITEFILE=51${PN}-gentoo.el

pkg_postinst() {
	elisp-site-regen
	elog "Redo is no longer enabled as a site default. Add the line"
	elog "  (require 'redo)"
	elog "to your ~/.emacs file to enable the redo/undo system."
}
