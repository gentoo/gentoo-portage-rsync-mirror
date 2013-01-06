# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/tuareg-mode/tuareg-mode-2.0.1.ebuild,v 1.6 2012/06/14 05:42:34 xmw Exp $

EAPI=4

inherit elisp

DESCRIPTION="An Objective Caml/Camllight mode for Emacs"
HOMEPAGE="http://forge.ocamlcore.org/projects/tuareg/"
SRC_URI="http://forge.ocamlcore.org/frs/download.php/410/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

S="${WORKDIR}/tuareg-${PV}"
ELISP_PATCHES="${P}-make_install.patch"
SITEFILE="50${PN}-gentoo.el"

src_install() {
	emake DEST="${D}/usr/share/emacs/site-lisp/tuareg-mode" install
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	dodoc HISTORY README
}
