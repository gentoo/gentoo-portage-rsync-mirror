# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/yow/yow-21.4_p20020329.ebuild,v 1.10 2012/11/03 12:35:36 ulm Exp $

EAPI=4

inherit elisp

XE_PV="1.15"
DESCRIPTION="Zippy the pinhead data base"
HOMEPAGE="http://www.gnu.org/software/emacs/"
# We used to take the file from the GNU Emacs 21.4 tarball, but 20 MB for one
# 53 kB file is wasteful. So we take it from app-xemacs/cookie and patch it.
SRC_URI="http://ftp.xemacs.org/pub/xemacs/packages/cookie-${XE_PV}-pkg.tar.gz
	mirror://gentoo/${PN}-${XE_PV}-${PV}.patch.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 x86"

S="${WORKDIR}"
ELISP_PATCHES="${PN}-${XE_PV}-${PV}.patch"
SITEFILE="50${PN}-gentoo.el"

src_compile() { :; }

src_install() {
	insinto "${SITEETC}/${PN}"
	doins etc/yow.lines
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
}

pkg_postinst() {
	elisp-site-regen

	elog "To add a menu-bar item for \"yow\" (as it used to be in Emacs 21),"
	elog "add the following lines to your ~/.emacs file:"
	elog
	elog "  (define-key-after menu-bar-games-menu [yow]"
	elog "    '(menu-item \"Random Quotation\" yow"
	elog "                :help \"Display a random Zippy quotation\"))"
}
