# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jmock/jmock-1.1.0-r2.ebuild,v 1.10 2013/06/27 22:01:04 aballier Exp $

JAVA_PKG_IUSE="doc examples source test"
inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Library for testing Java code using mock objects."
SRC_URI="http://${PN}.codehaus.org/${P}-src.zip"
HOMEPAGE="http://jmock.codehaus.org"
LICENSE="BSD"
SLOT="1.0"
KEYWORDS="amd64 ppc ppc64 x86 ~amd64-fbsd ~amd64-linux ~x86-linux"
IUSE=""

COMMON_DEPEND="
	=dev-java/cglib-2.0*
	=dev-java/junit-3*"

RDEPEND=">=virtual/jre-1.4
	${COMMON_DEPEND}"

DEPEND=">=virtual/jdk-1.4
	${COMMON_DEPEND}
	app-arch/unzip
	test? ( dev-java/ant-junit )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/1.1.0-build.xml.patch"
	epatch "${FILESDIR}/1.1.0-junit-3.8.2.patch"

	cd ${S}/lib || die
	rm -v *.jar || die
	java-pkg_jar-from cglib-2,junit
}

EANT_BUILD_TARGET="core.jar cglib.jar"

src_test() {
	ANT_TASKS="ant-junit" eant core.test.unit cglib.test.unit
}

src_install() {
	java-pkg_newjar build/dist/jars/${PN}-SNAPSHOT.jar
	java-pkg_newjar build/dist/jars/${PN}-cglib-SNAPSHOT.jar ${PN}-cglib.jar
	dodoc CHANGELOG || die
	dohtml overview.html || die

	use doc && java-pkg_dojavadoc build/javadoc-*
	use examples && java-pkg_doexamples examples
	use source && java-pkg_dosrc core/src/org
}
