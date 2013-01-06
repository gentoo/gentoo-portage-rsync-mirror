# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/elscreen/elscreen-1.4.6.ebuild,v 1.5 2009/07/02 17:07:35 jer Exp $

inherit elisp

DESCRIPTION="Frame configuration management for GNU Emacs modelled after GNU Screen"
HOMEPAGE="http://www.morishima.net/~naoto/j/software/elscreen/"
SRC_URI="ftp://ftp.morishima.net/pub/morishima.net/naoto/ElScreen/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ~ia64 ~ppc ~ppc64 sparc x86"
IUSE=""

DEPEND="app-emacs/apel"
RDEPEND="${DEPEND}"

SITEFILE=50${PN}-gentoo.el
DOCS="ChangeLog README"

pkg_postinst() {
	elisp-site-regen

	echo
	elog "ElScreen modifies standard Emacs keybindings and is therefore"
	elog "no longer loaded from site-gentoo.el. Add the line"
	elog "  (require 'elscreen)"
	elog "to your ~/.emacs file to enable it on Emacs startup."
}
