# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/remember/remember-2.0.ebuild,v 1.3 2012/12/01 19:43:59 armin76 Exp $

inherit elisp eutils

DESCRIPTION="Simplify writing short notes in emacs"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/RememberMode"
SRC_URI="http://download.gna.org/remember-el/${P}.tar.gz"

LICENSE="GPL-3 FDL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="bbdb planner"
# tests require bibl-mode, restrict for now
RESTRICT="test"

RDEPEND="bbdb? ( app-emacs/bbdb )
	planner? ( app-emacs/planner )"
DEPEND="${RDEPEND}"

SITEFILE=50${PN}-gentoo.el

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-1.9-make-elc.patch"
}

src_compile() {
	local EL="remember.el read-file-name.el"
	use bbdb && EL="${EL} remember-bbdb.el"
	use planner && EL="${EL} remember-planner.el remember-experimental.el"

	emake EL="${EL}" || die "emake failed"
}

src_install() {
	elisp-install ${PN} *.el *.elc || die "elisp-install failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" \
		|| die "elisp-site-file-install failed"
	doinfo remember.info remember-extra.info
	dodoc ChangeLog* NEWS
}
