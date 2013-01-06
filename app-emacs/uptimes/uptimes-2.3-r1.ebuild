# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/uptimes/uptimes-2.3-r1.ebuild,v 1.5 2007/11/26 23:33:28 ranger Exp $

inherit elisp

DESCRIPTION="Track and display emacs session uptimes"
HOMEPAGE="http://www.davep.org/emacs/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

SITEFILE=51${PN}-gentoo.el

pkg_postinst() {
	elisp-site-regen
	elog "Uptimes is no longer enabled as a site default. Add the following"
	elog "line to your ~/.emacs file to enable tracking of session uptimes:"
	elog "  (require 'uptimes)"
}
