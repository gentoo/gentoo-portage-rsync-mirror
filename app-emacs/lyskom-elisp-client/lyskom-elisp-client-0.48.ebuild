# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/lyskom-elisp-client/lyskom-elisp-client-0.48.ebuild,v 1.6 2007/07/03 09:45:44 opfer Exp $

inherit elisp

MY_P="${PN}-all-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Elisp client for the LysKOM conference system"
HOMEPAGE="http://www.lysator.liu.se/lyskom/klienter/emacslisp/index.en.html"
SRC_URI="http://www.lysator.liu.se/lyskom/klienter/emacslisp/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 sparc x86"
IUSE=""

SITEFILE=50lyskom-elisp-client-gentoo.el
DOCS="NEWS-* README"

src_unpack() {
	unpack ${A}
	cd "${S}"
	mv lyskom-all-${PV}.el lyskom.el
}

pkg_postinst() {
	elisp-site-regen
	ewarn
	ewarn "If you prefer Swedish language environment, add"
	ewarn "\t(setq-default kom-default-language 'sv)"
	ewarn "to your emacs configuration file."
	ewarn
}
