# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pdfjam/pdfjam-1.20.ebuild,v 1.7 2009/01/20 07:55:23 aballier Exp $

DESCRIPTION="pdfnup, pdfjoin and pdf90"
HOMEPAGE="http://www.warwick.ac.uk/go/pdfjam"
SRC_URI="http://www2.warwick.ac.uk/fac/sci/statistics/staff/academic/firth/software/pdfjam/${P/-/_}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE=""
S=${WORKDIR}/${PN}

DEPEND="virtual/latex-base"
RDEPEND="${DEPEND}"

src_compile() {
	for i in pdf90 pdfjoin pdfnup; do
		cp scripts/$i scripts/$i.orig
		sed -e 's,^pdflatex="/usr/local/bin/pdflatex",pdflatex="/usr/bin/pdflatex",' scripts/$i.orig >scripts/$i
	done
}

src_install() {
	dobin scripts/pdf90 scripts/pdfjoin scripts/pdfnup || die
	dodoc PDFjam-README.html || die
	doman man1/pdf90.1 man1/pdfjoin.1 man1/pdfnup.1 || die
}
