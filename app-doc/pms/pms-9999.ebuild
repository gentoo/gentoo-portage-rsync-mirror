# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/pms/pms-9999.ebuild,v 1.6 2014/04/03 16:56:35 ulm Exp $

EAPI=5

inherit git-r3

EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/${PN}.git
	http://git.overlays.gentoo.org/gitroot/proj/${PN}.git"

DESCRIPTION="Gentoo Package Manager Specification (draft)"
HOMEPAGE="http://wiki.gentoo.org/wiki/Project:PMS"

LICENSE="CC-BY-SA-3.0"
SLOT="live"
IUSE="html"

DEPEND="dev-tex/leaflet
	dev-texlive/texlive-bibtexextra
	dev-texlive/texlive-latex
	dev-texlive/texlive-latexextra
	dev-texlive/texlive-latexrecommended
	dev-texlive/texlive-science
	html? (
		app-text/recode
		>=dev-tex/tex4ht-20090115_p0029
	)"
RDEPEND=""

src_compile() {
	emake
	use html && emake html
}

src_install() {
	dodoc pms.pdf eapi-cheatsheet.pdf
	if use html; then
		dohtml *.html pms.css $(shopt -s nullglob; echo *.png)
		dosym {..,/usr/share/doc/${PF}/html}/eapi-cheatsheet.pdf
	fi
}
