# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/pms/pms-5-r1.ebuild,v 1.1 2013/08/09 21:07:47 ulm Exp $

EAPI=5

DESCRIPTION="Gentoo Package Manager Specification"
HOMEPAGE="http://www.gentoo.org/proj/en/qa/pms.xml"
SRC_URI="!binary? ( mirror://gentoo/${P}.tar.xz )
	binary? ( mirror://gentoo/${P}.pdf )"

LICENSE="CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~hppa-hpux ~ia64-hpux ~x86-interix ~amd64-linux ~arm-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~x86-netbsd ~ppc-openbsd ~x64-openbsd ~x86-openbsd ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris ~x86-winnt"
IUSE="binary html"

DEPEND="!binary? (
		dev-tex/leaflet
		dev-texlive/texlive-bibtexextra
		dev-texlive/texlive-latex
		dev-texlive/texlive-latexextra
		dev-texlive/texlive-latexrecommended
		dev-texlive/texlive-science
		html? (
			app-text/recode
			>=dev-tex/tex4ht-20090115_p0029
		)
	)"
RDEPEND=""

src_unpack() {
	if use !binary; then
		unpack ${A}
	else
		S="${WORKDIR}"
		cp "${DISTDIR}"/${P}.pdf pms.pdf || die
	fi
}

src_compile() {
	if use !binary; then
		emake
		use html && emake html
	fi
}

src_install() {
	dodoc pms.pdf
	if use !binary; then
		dodoc eapi-cheatsheet.pdf
		if use html; then
			dohtml *.html pms.css $(shopt -s nullglob; echo *.png)
			dosym {..,/usr/share/doc/${PF}/html}/eapi-cheatsheet.pdf
		fi
	else
		use html && ewarn "USE=\"html\" has no effect with USE=\"binary\"."
	fi
}
