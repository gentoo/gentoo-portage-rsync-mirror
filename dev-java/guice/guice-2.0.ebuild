# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/guice/guice-2.0.ebuild,v 1.1 2013/09/25 17:20:14 ercpe Exp $

EAPI="5"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Guice is a lightweight dependency injection framework for Java 5 and above"
HOMEPAGE="http://code.google.com/p/google-guice/"
SRC_URI="http://google-guice.googlecode.com/files/${P}-src.zip"

LICENSE="Apache-2.0"
SLOT="2"
KEYWORDS="~amd64 ~x86"

IUSE=""

COMMON_DEPEND="dev-java/aopalliance:1
	dev-java/asm:3
	dev-java/cglib:2.2"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEPEND}"
DEPEND=">=virtual/jdk-1.5
	${COMMON_DEPEND}"

S="${WORKDIR}/${P}-src/"

RESTRICT="test"

JAVA_PKG_BSFIX_NAME="build.xml common.xml servlet/build.xml"
JAVA_ANT_CLASSPATH_TAGS="${JAVA_ANT_CLASSPATH_TAGS} javadoc"

JAVA_ANT_REWRITE_CLASSPATH="yes"
EANT_GENTOO_CLASSPATH="aopalliance-1,asm-3,cglib-2.2"

java_prepare() {
	find . -name '*.jar' -delete || die
	find . -name '*.class' -delete || die
	epatch "${FILESDIR}"/${PV}-common.xml.patch
	epatch "${FILESDIR}"/${PV}-build.xml.patch
}

src_install() {
	java-pkg_dojar build/${PN}.jar

	use doc && java-pkg_dojavadoc javadoc/
	use source && java-pkg_dosrc src/com
}
