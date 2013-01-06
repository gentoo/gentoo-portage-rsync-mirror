# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/emacs-wiki/emacs-wiki-2.72-r1.ebuild,v 1.4 2012/12/01 19:46:12 armin76 Exp $

NEED_EMACS=22

inherit elisp

DESCRIPTION="Maintain a local Wiki using Emacs-friendly markup"
HOMEPAGE="http://www.mwolson.org/projects/EmacsWiki.html
	http://www.emacswiki.org/cgi-bin/wiki.pl?EmacsWikiMode"
SRC_URI="http://www.mwolson.org/static/dist/emacs-wiki/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="app-emacs/htmlize
	app-emacs/httpd"

RDEPEND="${DEPEND}"

SITEFILE=50${PN}-gentoo.el

src_unpack() {
	unpack ${A}
	# These will be made part of the emacs-wiki installation until
	# they are packaged separately
	mv "${S}"/contrib/{update-remote,cgi}.el "${S}"/
}

src_compile() {
	elisp-compile *.el || die "elisp-compile failed"
	makeinfo emacs-wiki.texi || die "makeinfo failed"
}

src_install() {
	elisp-install ${PN} *.{el,elc} || die "elisp-install failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" \
		|| die "elisp-site-file-install failed"
	doinfo *.info*
	dodoc README ChangeLog*
	docinto examples
	dodoc examples/default.css
}
