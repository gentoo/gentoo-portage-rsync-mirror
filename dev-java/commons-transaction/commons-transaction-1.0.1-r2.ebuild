# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-transaction/commons-transaction-1.0.1-r2.ebuild,v 1.2 2009/05/23 07:58:02 betelgeuse Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="A library of utility classes commonly used in transactional Java programming."
SRC_URI="mirror://apache/jakarta/commons/transaction/source/${P}-src.tgz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.4
	dev-java/commons-codec
	java-virtuals/transaction-api
	dev-java/log4j"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	rm -v *.jar || die
	cd "${S}/lib"
	rm -v *.jar || die
}

JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_GENTOO_CLASSPATH="commons-codec,log4j,transaction-api"
EANT_DOC_TARGET="javadocs"

src_install() {
	java-pkg_newjar dist/lib/${P}.jar ${PN}.jar

	dodoc NOTICE.txt README.txt RELEASE-NOTES.txt || die
	dohtml -r xdocs/* || die
	use doc && java-pkg_dojavadoc build/doc/apidocs
	use source && java-pkg_dosrc src/java/*
}
