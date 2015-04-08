# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/struts-xwork/struts-xwork-2.3.15.2.ebuild,v 1.2 2013/10/05 11:17:52 tomwij Exp $

EAPI="5"

JAVA_PKG_IUSE="doc examples source test"

inherit java-pkg-2 java-ant-2

MY_PN="struts"
MY_P="${MY_PN}-${PV}-src"

DESCRIPTION="A powerful Model View Controller Framework for JSP/Servlets: XWork Core"
SRC_URI="mirror://apache/struts/source/${MY_P}.zip
	http://dev.gentoo.org/~tomwij/files/dist/${MY_PN}-build.xml-${PV}.tar.xz"
HOMEPAGE="http://struts.apache.org/index.html"

LICENSE="Apache-2.0"
SLOT="2"
KEYWORDS="~amd64"

COMMON_DEPS="dev-java/asm:3
	dev-java/commons-io:1
	dev-java/commons-lang:3.1
	dev-java/commons-logging:0
	dev-java/ognl:3.0
	dev-java/slf4j-api:0"

RDEPEND=">=virtual/jre-1.5
	${COMMON_DEPS}"

DEPEND=">=virtual/jdk-1.5
	test? ( dev-java/ant-junit:0 )
	${COMMON_DEPS}"

S="${WORKDIR}/${MY_PN}-${PV}/src/xwork-core"

JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_GENTOO_CLASSPATH="asm-3,commons-io-1,commons-lang-3.1,commons-logging,ognl-3.0,slf4j-api"

# Could not open files of the name xwork-jar.xml
RESTRICT="test"

src_unpack() {
	unpack ${MY_P}.zip
	cd "${WORKDIR}"/${MY_PN}-${PV}/src || die
	unpack ${MY_PN}-build.xml-${PV}.tar.xz
}

java_prepare() {
	find . -name '*.jar' -print -delete || die
}

src_test() {
	EANT_TEST_EXTRA_ARGS="-Djunit.present=true" java-pkg-2_src_test
}

src_install() {
	java-pkg_dojar target/xwork-core.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/com
}
