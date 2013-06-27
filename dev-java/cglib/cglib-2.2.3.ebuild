# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/cglib/cglib-2.2.3.ebuild,v 1.2 2013/06/27 21:58:12 aballier Exp $

EAPI=5
JAVA_PKG_IUSE="test doc examples source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="cglib is a powerful, high performance and quality Code Generation Library."
HOMEPAGE="http://cglib.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}.${PV}.zip"
LICENSE="Apache-2.0"
SLOT="2.2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-fbsd ~amd64-linux ~x86-linux ~sparc-solaris ~x86-solaris"

COMMON_DEP="dev-java/asm:3
	>=dev-java/ant-core-1.7.0:0"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	test? ( dev-java/junit:0 )
	${COMMON_DEP}"

S=${WORKDIR}

EANT_GENTOO_CLASSPATH="asm-3,ant-core"
JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_TEST_JUNIT_INTO="lib"
EANT_TEST_EXTRA_ARGS="-DdebugLocation=${T}/debug"

src_unpack() {
	unpack ${A}
	cd "${S}"
	unzip -q ${PN}-src-${PV}.jar || die
}

java_prepare() {
	epatch "${FILESDIR}"/${P}-build.patch

	# fix line endings otherwise patch fails
	edos2unix src/test/net/sf/cglib/CodeGenTestCase.java
	# mem leak tests fail on ppc #284316
	# assuming gc() guarantees to free all memory is wrong, so don't make them fail
	epatch "${FILESDIR}/${PN}-2.2-no-leak-test.patch"

	cp "${FILESDIR}"/words.txt src/test/net/sf/cglib/util/ || die

	find . -name '*.jar' -delete
}

src_test() {
	java-pkg-2_src_test
}

src_install() {
	java-pkg_newjar dist/${P}.jar
	dodoc NOTICE README

	use doc && java-pkg_dojavadoc docs
	use source && java-pkg_dosrc src/proxy/net
	use examples && java-pkg_doexamples --subdir samples src/proxy/samples
}
