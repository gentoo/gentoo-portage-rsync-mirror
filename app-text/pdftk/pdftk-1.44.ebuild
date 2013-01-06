# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pdftk/pdftk-1.44.ebuild,v 1.5 2012/09/16 20:39:01 chithanh Exp $

EAPI="2"

inherit eutils

DESCRIPTION="A tool for manipulating PDF documents"
HOMEPAGE="http://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/"
SRC_URI="http://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/${P}-src.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ppc x86"
IUSE=""
DEPEND=">=sys-devel/gcc-4.3.1[gcj]"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}-dist/${PN}

src_prepare() {
	epatch "${FILESDIR}/${P}-Makefile.patch"
	epatch "${FILESDIR}/${P}-LDFLAGS.patch"
}

src_compile() {
	# java-config settings break compilation by gcj.
	unset CLASSPATH
	unset JAVA_HOME
	# parallel make fails
	emake -j1 -f "${S}"/Makefile.Debian || die "Compilation failed."
}

src_install() {
	dobin pdftk || die
	doman ../pdftk.1 || die
	dohtml ../pdftk.1.html || die
}
