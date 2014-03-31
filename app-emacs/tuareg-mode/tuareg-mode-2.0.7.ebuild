# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/tuareg-mode/tuareg-mode-2.0.7.ebuild,v 1.2 2014/03/31 11:23:00 nimiux Exp $

EAPI=5

inherit elisp

DESCRIPTION="An Objective Caml/Camllight mode for Emacs"
HOMEPAGE="http://forge.ocamlcore.org/projects/tuareg/"
SRC_URI="http://forge.ocamlcore.org/frs/download.php/1304/tuareg-${PV}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86 ~x86-fbsd"

S="${WORKDIR}/tuareg-${PV}"
ELISP_REMOVE="tuareg-pkg.el tuareg-site-file.el"
SITEFILE="50${PN}-gentoo-2.0.6.el"
DOCS="README"
