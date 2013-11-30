# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/charva/charva-1.0.1-r1.ebuild,v 1.6 2013/11/30 08:11:04 tomwij Exp $

JAVA_PKG_IUSE="doc examples source"

inherit java-pkg-2

DESCRIPTION="A Java Windowing Toolkit for Text Terminals"
SRC_URI="http://www.pitman.co.za/projects/charva/download/${P}.tar.gz"
HOMEPAGE="http://www.pitman.co.za/projects/charva/"
RDEPEND=">=virtual/jre-1.3
		sys-libs/ncurses"
DEPEND=">=virtual/jdk-1.3
		${RDEPEND}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"

src_unpack() {
	unpack ${A}
	rm -v "${S}/c/src/libTerminal.so"
	sed -e "s,javac,javac $(java-pkg_javac-args)," -i "${S}"/java/src/Makefile || die
}

src_compile() {
	cd c/src
	make -f Makefile.linux || die

	cd "${S}/java/src"
	make || die
}

src_install() {
	java-pkg_dojar java/lib/${PN}.jar
	dodoc README || die
	use doc && java-pkg_dojavadoc java/doc
	use examples && java-pkg_doexamples java/src/example
	use source && java-pkg_dosrc java/src/{charva,charvax}

	cd c/src/
	java-pkg_doso *.so
}
