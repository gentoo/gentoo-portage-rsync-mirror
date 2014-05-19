# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/netty-common/netty-common-4.0.19.ebuild,v 1.1 2014/05/19 12:35:12 tomwij Exp $

EAPI="5"

JAVA_PKG_IUSE="doc source test"

inherit java-pkg-2 java-ant-2

MY_PN="netty"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Async event-driven framework for rapid development of high performance network applications"
HOMEPAGE="http://netty.io/"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/archive/${MY_P}.Final.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=virtual/jre-1.6"

DEPEND=">=virtual/jdk-1.6
	dev-java/commons-logging:0
	dev-java/javassist:3
	dev-java/log4j:0
	dev-java/slf4j-api:0
	test? (
		dev-java/ant-core:0
		dev-java/easymock:3.2
		dev-java/junit:4
	)"

S="${WORKDIR}/${MY_PN}-${MY_P}.Final/${PN/${MY_PN}-}"

EANT_BUILD_TARGET="package"
JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_TEST_EXTRA_ARGS+=" -Djunit.present=true"

# Tests fail as they might need logging to be properly set up and/or compatible.
#
# junit.framework.AssertionFailedError: expected:<[foo]> but was:<[NOP]>
# at io.netty.util.internal.logging.Slf4JLoggerFactoryTest.testCreation
RESTRICT="test"

java_prepare() {
	EANT_EXTRA_ARGS="-Dgentoo.classpath=$(java-pkg_getjars --build-only commons-logging,log4j,javassist-3,slf4j-api)"

	cp "${FILESDIR}"/${P}-build.xml build.xml || die

	# Remove the odd memory restriction in the generated build files.
	sed -i 's/memoryMaximumSize="256m"//' build.xml || die
}

src_test() {
	EANT_EXTRA_ARGS="${EANT_EXTRA_ARGS}:$(java-pkg_getjars --build-only ant-core,easymock-3.2,junit-4)"

	ANT_TASKS="ant-junit" java-pkg-2_src_test
}

src_install() {
	java-pkg_newjar target/${MY_PN}-*.jar ${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java
}
