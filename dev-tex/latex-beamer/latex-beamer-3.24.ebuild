# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/latex-beamer/latex-beamer-3.24.ebuild,v 1.8 2013/01/06 14:44:46 maekke Exp $

EAPI=5

inherit latex-package

DESCRIPTION="LaTeX class for creating presentations using a video projector"
HOMEPAGE="http://bitbucket.org/rivanvx/beamer/wiki/Home"
SRC_URI="mirror://gentoo/${P}.zip"

LICENSE="GPL-2 FDL-1.2 LPPL-1.3c"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ia64 ~mips ppc ppc64 ~s390 ~sh sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="doc examples lyx"

DEPEND="app-arch/unzip
	lyx? ( app-office/lyx )
	dev-texlive/texlive-latex"
RDEPEND=">=dev-tex/pgf-1.10
	dev-tex/xcolor
	!dev-tex/translator"

S=${WORKDIR}/beamer

src_install() {
	insinto /usr/share/texmf-site/tex/latex/beamer
	doins -r base

	if use lyx ; then
		insinto /usr/share/lyx/examples
		doins examples/lyx-based-presentation/*
	fi

	dodoc AUTHORS ChangeLog README TODO doc/licenses/LICENSE

	if use doc ; then
		docinto doc
		dodoc -r doc/*
	fi

	if use examples ; then
		rm -f "${S}"/examples/a-lecture/{*.tex~,._beamerexample-lecture-pic*}
		if ! use lyx ; then
			einfo "Removing lyx examples as lyx useflag is not set"
			find "${S}" -name "*.lyx" -print -delete
		fi
		dodoc -r examples solutions
	fi
}
