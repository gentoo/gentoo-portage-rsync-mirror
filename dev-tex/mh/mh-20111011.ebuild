# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/mh/mh-20111011.ebuild,v 1.11 2012/05/24 21:41:41 aballier Exp $

inherit latex-package

DESCRIPTION="Additional LaTeX math tools."
HOMEPAGE="http://www.ctan.org/tex-archive/macros/latex/contrib/mh/"
SRC_URI="mirror://gentoo/${P}.zip"
LICENSE="LPPL-1.3"
SLOT="0"
IUSE="doc"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"

RDEPEND="dev-tex/xcolor
	>=dev-texlive/texlive-latexrecommended-2011"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${PN}
TEXMF=/usr/share/texmf-site

src_compile() {
	# To avoid sandbox violations
	export VARTEXFONTS="${T}/fonts"

	# Unpacking *.dtx
	for i in *.dtx; do
		tex ${i} || die "TeXing ${i} failed"
	done

	latex-package_src_compile
}

src_install() {
	latex-package_src_doinstall styles fonts bin

	insinto "${TEXMF}/tex/latex/${PN}"
	doins *.sym

	use doc && latex-package_src_doinstall doc
	dodoc README
}
