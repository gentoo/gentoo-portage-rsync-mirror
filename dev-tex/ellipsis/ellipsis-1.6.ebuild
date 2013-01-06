# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/ellipsis/ellipsis-1.6.ebuild,v 1.3 2012/11/09 19:01:10 ago Exp $

inherit latex-package

DESCRIPTION="Simple package that fixes the way LaTeX centers ellipses."
HOMEPAGE="http://www.ctan.org/tex-archive/macros/latex/contrib/ellipsis/"
# Downloaded from:
# ftp://tug.ctan.org/tex-archive/macros/latex/contrib/ellipsis.zip
SRC_URI="mirror://gentoo/${P}.zip"
IUSE=""
KEYWORDS="~amd64 ~x86"
LICENSE="LPPL-1.2"
SLOT="0"

DEPEND="app-arch/unzip"

S="${WORKDIR}/${PN}"

src_install() {

	latex-package_src_install

	dodoc README ellipsis.pdf \
		|| die "Installing the documentation failed."
}
