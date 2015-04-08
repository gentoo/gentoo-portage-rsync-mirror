# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/slatex/slatex-20050609.ebuild,v 1.5 2014/08/10 21:27:49 slyfox Exp $

# for updating the texmf database, id est latex-package_rehash
inherit latex-package

DESCRIPTION="SLaTeX  is a Scheme program that allows you to write Scheme code in your (La)TeX source"
HOMEPAGE="http://www.ccs.neu.edu/home/dorai/slatex/slatxdoc.html"
#http://www.ccs.neu.edu/home/dorai/slatex/slatex.tar.gz
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="freedist" # license doesn't grant the right for modifications
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="dev-scheme/guile"
DEPEND="${CDEPEND} dev-scheme/scmxlate !dev-scheme/plt-scheme"
RDEPEND="${CDEPEND}"

S="${WORKDIR}/${PN}"

TARGET_DIR="/usr/share/slatex"

src_unpack() {
	unpack ${A}; cd "${S}"
#	cp scmxlate-slatex-src.scm scmxlate-slatex-src.scm.old
	sed "s:\"/home/dorai/.www/slatex/slatex.scm\":\"${TARGET_DIR}/slatex.scm\":" -i scmxlate-slatex-src.scm
#	diff -u scmxlate-slatex-src.scm.old scmxlate-slatex-src.scm
}

src_compile() {
	local command="(load \"/usr/share/scmxlate/scmxlate.scm\")"
#	echo "${command}"
	guile -c "${command}" <<< "guile" || die
#	mzscheme -e "${command}(exit)" <<< "mzscheme" || die
#	guile -c "(load \"slatex.scm\")(slatex::process-main-tex-file \"slatxdoc.tex\")" && tex slatxdoc.tex
}

src_install() {
	insinto "${TARGET_DIR}"; doins slatex.scm
	insinto /usr/share/texmf/tex/latex/slatex/; doins slatex.sty
	dobin slatex
}
