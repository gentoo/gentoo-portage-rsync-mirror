# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mmm-mode/mmm-mode-0.4.8-r2.ebuild,v 1.4 2010/10/14 16:50:27 ranger Exp $

inherit elisp

DESCRIPTION="Enables the user to edit different parts of a file in different major modes"
HOMEPAGE="http://mmm-mode.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

ELISP_PATCHES="${P}-format-mode-line.patch"
SITEFILE="50${PN}-gentoo.el"

src_compile() {
	econf --with-emacs
	emake -j1 || die "emake failed"
}

src_install() {
	elisp-install ${PN} *.el *.elc || die
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	doinfo *.info* || die
	dodoc AUTHORS ChangeLog FAQ NEWS README README.Mason TODO
}
