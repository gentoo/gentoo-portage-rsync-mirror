# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/tuareg-mode/tuareg-mode-2.0.4.ebuild,v 1.3 2011/11/06 17:30:54 armin76 Exp $

EAPI=4

inherit elisp

DESCRIPTION="An Objective Caml/Camllight mode for Emacs"
HOMEPAGE="http://forge.ocamlcore.org/projects/tuareg/"
SRC_URI="http://forge.ocamlcore.org/frs/download.php/514/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

S="${WORKDIR}/tuareg-${PV}"
ELISP_PATCHES="${PN}-2.0.1-make_install.patch"
SITEFILE="50${PN}-gentoo.el"

src_install() {
	emake DEST="${D}/usr/share/emacs/site-lisp/tuareg-mode" install
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	dodoc HISTORY README
}
