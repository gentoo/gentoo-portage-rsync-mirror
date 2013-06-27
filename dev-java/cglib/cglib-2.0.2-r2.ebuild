# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/cglib/cglib-2.0.2-r2.ebuild,v 1.18 2013/06/27 21:58:12 aballier Exp $

EAPI=2
JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="A powerful, high performance and quality Code Generation Library."
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-${PV}.jar"
HOMEPAGE="http://cglib.sourceforge.net"
LICENSE="Apache-1.1"
SLOT="2"
KEYWORDS="amd64 ppc ppc64 x86 ~amd64-fbsd ~amd64-linux ~x86-linux"
COMMON_DEP="=dev-java/asm-1.4.3*
	=dev-java/aspectwerkz-2*
	dev-java/ant-core"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
#	test? ( dev-java/junit:0 )
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	${COMMON_DEP}"
IUSE=""

S=${WORKDIR}

java_prepare() {
	# needed for ecj-3.5
	java-ant_rewrite-bootclasspath auto

	epatch "${FILESDIR}/${P}-asm-1.4.3.patch"

	cd "${S}/lib"
	rm -v *.jar || die
	java-pkg_jar-from asm-1.4
	java-pkg_jar-from aspectwerkz-2
	java-pkg_jar-from ant-core ant.jar
}

#Investigate why this fails
EANT_FILTER_COMPILER="ecj-3.3"
EANT_TEST_JUNIT_INTO="lib"

# Fail and would need aspectwekrz-1.0
RESTRICT="test"

src_install() {
	java-pkg_newjar dist/${P}.jar
	java-pkg_newjar dist/${PN}-full-${PV}.jar ${PN}-full.jar

	dodoc NOTICE README || die
	use doc && java-pkg_dojavadoc docs
	use source && java-pkg_dosrc src/proxy/net
}
