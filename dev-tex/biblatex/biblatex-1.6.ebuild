# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/biblatex/biblatex-1.6.ebuild,v 1.3 2012/05/15 17:45:32 johu Exp $

inherit latex-package

DESCRIPTION="Reimplementation of the bibliographic facilities provided by LaTeX"
HOMEPAGE="http://www.ctan.org/tex-archive/macros/latex/contrib/biblatex"
SRC_URI="mirror://gentoo/${P}.zip"
LICENSE="LPPL-1.3"
SLOT="0"
IUSE="doc"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-texlive/texlive-bibtexextra"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${PN}
TEXMF=/usr/share/texmf-site

src_install() {
	insinto "${TEXMF}/tex/latex/${PN}"
	doins -r latex/* || die
	for i in bibtex/* ; do
		insinto "${TEXMF}/${i}/${PN}"
		doins ${i}/* || die
	done

	use doc && { pushd doc ; latex-package_src_doinstall doc ; popd ;}
	dodoc README RELEASE || die
}
