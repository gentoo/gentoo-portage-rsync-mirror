# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/cglib/cglib-2.2.ebuild,v 1.7 2014/08/10 20:09:21 slyfox Exp $

EAPI="2"
JAVA_PKG_IUSE="test doc examples source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="cglib is a powerful, high performance and quality Code Generation Library"
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-${PV}.jar"
HOMEPAGE="http://cglib.sourceforge.net"
LICENSE="Apache-2.0"
SLOT="2.2"
KEYWORDS="amd64 ppc ppc64 x86 ~amd64-linux ~x86-linux ~sparc-solaris ~x86-solaris"
COMMON_DEP="dev-java/asm:3
	>=dev-java/ant-core-1.7.0"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	test? ( dev-java/junit )
	${COMMON_DEP}"
IUSE=""

S=${WORKDIR}

src_prepare() {
	epatch "${FILESDIR}/${P}-build.patch"
	# mem leak tests fail on ppc #284316
	# assuming gc() guarantees to free all memory is wrong, so don't make them fail
	epatch "${FILESDIR}/${P}-no-leak-test.patch"

	cp "${FILESDIR}/words.txt" "${S}/src/test/net/sf/cglib/util/"
}

src_unpack() {
	unpack ${A}

	cd "${S}/lib"
	rm -v *.jar || die
	java-pkg_jar-from asm-3 asm.jar
	java-pkg_jar-from asm-3 asm-util.jar
	java-pkg_jar-from asm-3 asm-commons.jar
	java-pkg_jar-from ant-core ant.jar
}

EANT_TEST_JUNIT_INTO="lib"
EANT_TEST_EXTRA_ARGS="-DdebugLocation=${T}/debug"

src_test() {
	java-pkg-2_src_test
}

src_install() {
	java-pkg_newjar dist/${P}.jar ${PN}.jar

	dodoc NOTICE README || die
	use doc && java-pkg_dojavadoc docs
	use source && java-pkg_dosrc src/proxy/net
	use examples && java-pkg_doexamples --subdir samples src/proxy/samples
}
