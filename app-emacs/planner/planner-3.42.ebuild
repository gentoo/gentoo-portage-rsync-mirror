# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/planner/planner-3.42.ebuild,v 1.2 2012/12/01 19:45:08 armin76 Exp $

inherit elisp

DESCRIPTION="Maintain a local Wiki using Emacs-friendly markup"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/PlannerMode"
SRC_URI="http://download.gna.org/planner-el/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
RESTRICT="test"

DEPEND=">=app-emacs/muse-3.02.6a
	app-emacs/bbdb
	app-emacs/emacs-w3m"
RDEPEND="${DEPEND}"
PDEPEND="app-emacs/remember"

SITEFILE="80${PN}-gentoo.el"

src_compile() {
	emake || die
}

src_install() {
	elisp-install ${PN} *.el *.elc || die
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	doinfo planner-el.info || die
	dodoc AUTHORS COMMENTARY ChangeLog* NEWS README || die "dodoc failed"
}
