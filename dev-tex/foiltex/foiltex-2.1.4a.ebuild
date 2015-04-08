# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/foiltex/foiltex-2.1.4a.ebuild,v 1.6 2013/04/13 17:34:43 ulm Exp $

inherit latex-package

S=${WORKDIR}/${PN}

DESCRIPTION="LaTeX package used to create foils and slides"
HOMEPAGE="ftp://ftp.dante.de/tex-archive/help/Catalogue/entries/foiltex.html"
# Taken from ftp://ftp.dante.de/tex-archive/macros/latex/contrib/foiltex.tar.gz
# if not yet available on the gentoo-mirrors, move it to
# /usr/portage/distfiles/foiltex-2.1.4a.tar.gz
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="FoilTeX"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

src_install () {
	latex-package_src_doinstall all
	cd ${S}
	dodoc readme.flt
}
