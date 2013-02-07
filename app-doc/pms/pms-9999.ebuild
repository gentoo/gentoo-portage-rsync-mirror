# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/pms/pms-9999.ebuild,v 1.3 2013/02/07 21:34:12 ulm Exp $

EAPI=4
inherit git-2

EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/${PN}.git
	http://git.overlays.gentoo.org/gitroot/proj/${PN}.git"

DESCRIPTION="Gentoo Package Manager Specification (draft)"
HOMEPAGE="http://www.gentoo.org/proj/en/qa/pms.xml"
SRC_URI=""

LICENSE="CC-BY-SA-3.0"
SLOT="live"
KEYWORDS=""
IUSE="html"

DEPEND="html? ( >=dev-tex/tex4ht-20090115_p0029 )
	dev-tex/leaflet
	dev-texlive/texlive-bibtexextra
	dev-texlive/texlive-latex
	dev-texlive/texlive-latexrecommended
	dev-texlive/texlive-latexextra
	dev-texlive/texlive-science"
RDEPEND=""

src_compile() {
	emake
	use html && emake html
}

src_install() {
	dodoc pms.pdf
	use html && dohtml *.html pms.css $(shopt -s nullglob; echo *.png)
}
