# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/color-browser/color-browser-0.3-r1.ebuild,v 1.2 2009/05/05 07:50:46 fauli Exp $

inherit elisp eutils

DESCRIPTION="A utility for designing Emacs color themes"
HOMEPAGE="http://www.emacswiki.org/elisp/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~sparc"
IUSE=""

DEPEND="app-emacs/color-theme"
RDEPEND="${DEPEND}"

SITEFILE=60${PN}-gentoo.el

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-gentoo.patch"
}
