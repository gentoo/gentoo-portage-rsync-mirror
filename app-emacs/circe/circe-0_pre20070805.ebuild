# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/circe/circe-0_pre20070805.ebuild,v 1.3 2008/12/23 20:12:21 tcunha Exp $

inherit elisp

DESCRIPTION="A great IRC client for Emacs"
HOMEPAGE="http://www.nongnu.org/circe/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2 FDL-1.2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE=""

S="${WORKDIR}/${PN}"
SITEFILE="50${PN}-gentoo.el"
DOCS="FAQ README"

src_compile() {
	emake compile circe.info || die "emake failed"
}

src_install() {
	elisp_src_install
	doinfo circe.info*
}
