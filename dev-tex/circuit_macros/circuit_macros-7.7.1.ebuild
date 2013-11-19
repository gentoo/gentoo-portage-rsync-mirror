# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/circuit_macros/circuit_macros-7.7.1.ebuild,v 1.1 2013/11/19 16:34:00 calchan Exp $

EAPI=5

inherit unpacker texlive-common

DESCRIPTION="M4 Macros for Electric circuit diagrams in TeX or LaTeX"
HOMEPAGE="https://ece.uwaterloo.ca/~aplevich/Circuit_macros/"
SRC_URI="http://mirrors.ctan.org/graphics/circuit_macros.zip -> circuit_macros-${PV}.zip"

LICENSE="LPPL-1.3c"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples +script"

DEPEND=""
RDEPEND="|| ( app-text/texlive[graphics] app-text/texlive[pstricks] )
	media-gfx/dpic
	sys-devel/m4
	script? ( app-text/texlive[graphics]
		dev-texlive/texlive-latexextra )"

S="${WORKDIR}/${PN}"

src_compile() {
	:
}

src_install() {
	insinto /usr/share/${PN}
	doins *.m4
	insinto /usr/share/texmf-site/tex/latex/${PN}
	doins boxdims.sty
	dodoc README CHANGES Makefile doc/CMman.pdf
	rm -f doc/CMman.pdf
	use doc && dodoc -r doc
	use examples && dodoc -r examples
	use script && dobin "${FILESDIR}/cm2pdf"
	docompress -x \
		/usr/share/doc/${PF}/Makefile \
		/usr/share/doc/${PF}/doc \
		/usr/share/doc/${PF}/examples
}

pkg_postinst() {
	etexmf-update
	use script && einfo "cm2pdf was installed to automatically create PDFs. Run cm2pdf --help for usage help."
}

pkg_postrm() {
	etexmf-update
}
