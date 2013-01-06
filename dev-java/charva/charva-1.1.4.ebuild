# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/charva/charva-1.1.4.ebuild,v 1.1 2010/03/20 16:46:52 betelgeuse Exp $

EAPI="2"
JAVA_PKG_IUSE="doc examples source"
WANT_ANT_TASKS="ant-nodeps"

inherit java-pkg-2 java-ant-2

DESCRIPTION="A Java Windowing Toolkit for Text Terminals"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${P}/charva.zip -> ${P}.zip"
HOMEPAGE="http://www.pitman.co.za/projects/charva/"
RDEPEND=">=virtual/jre-1.5
		sys-libs/ncurses
		dev-java/commons-logging:0"
DEPEND=">=virtual/jdk-1.5
		${RDEPEND}"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

S="${WORKDIR}/${PN}"

java_prepare() {
	rm -v ./c/lib/*.so || die
	rm -v java/lib/* || die
	rm -v java/dist/lib/* || die
	find . -name "*.class" -print -delete || die
}

JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_GENTOO_CLASSPATH="commons-logging"
EANT_BUILD_TARGET="dist"

src_compile() {
	java-pkg-2_src_compile
	cd c/src
	emake -f Makefile.linux.txt || die "building native lib failed"
}

src_install() {
	java-pkg_dojar ./java/dist/lib/charva.jar
	use doc && java-pkg_dojavadoc docs/api
	use examples && java-pkg_doexamples test/src/example
	use source && java-pkg_dosrc java/src/{charva,charvax}

	java-pkg_doso c/lib/*.so
}
