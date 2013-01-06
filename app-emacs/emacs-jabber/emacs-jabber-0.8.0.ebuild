# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/emacs-jabber/emacs-jabber-0.8.0.ebuild,v 1.7 2010/05/14 14:45:07 ulm Exp $

NEED_EMACS=22

inherit elisp

DESCRIPTION="A Jabber client for Emacs"
HOMEPAGE="http://emacs-jabber.sourceforge.net/
	http://emacswiki.org/cgi-bin/wiki/JabberEl"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DOCS="AUTHORS NEWS README"
SITEFILE="70${PN}-gentoo.el"

src_compile() {
	elisp_src_compile
	makeinfo jabber.texi || die
}

src_install() {
	elisp_src_install
	doinfo jabber.info || die
}

pkg_postinst() {
	elisp_pkg_postinst
	elog "If you want to use SASL authentication, you need either Emacs 23,"
	elog "or install virtual/emacs-flim."
}
