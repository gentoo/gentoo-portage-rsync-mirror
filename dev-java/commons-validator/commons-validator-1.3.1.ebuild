# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-validator/commons-validator-1.3.1.ebuild,v 1.7 2010/05/18 14:07:52 betelgeuse Exp $

EAPI=1
JAVA_PKG_IUSE="doc examples source test"

inherit java-pkg-2 java-ant-2

MY_P=${P}-src
DESCRIPTION="Commons component to validate user input, or data input"
HOMEPAGE="http://commons.apache.org/validator/"
SRC_URI="mirror://apache/commons/validator/source/${P}-src.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=virtual/jre-1.4
	dev-java/jakarta-oro:2.0
	>=dev-java/commons-digester-1.6
	>=dev-java/commons-collections-3.1
	>=dev-java/commons-logging-1.0.4
	dev-java/commons-beanutils:1.7"

DEPEND=">=virtual/jdk-1.4
	test? ( dev-java/junit:0 )
	${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/validator-1.3.build.xml.patch"
	JAVA_ANT_CLASSPATH_TAGS="javac java" java-ant_rewrite-classpath

	echo "oro.jar=$(java-pkg_getjars jakarta-oro-2.0)" >> build.properties
	echo "commons-digester.jar=$(java-pkg_getjars commons-digester)" >> build.properties
	echo "commons-beanutils.jar=$(java-pkg_getjars commons-beanutils-1.7)" >> build.properties
	local logjar="$(java-pkg_getjar commons-logging commons-logging.jar)"
	echo "commons-logging.jar=${logjar}" >> build.properties
	echo "commons-collections.jar=$(java-pkg_getjars commons-collections)" >> build.properties
}

EANT_EXTRA_ARGS="-Dskip.download=true"
EANT_BUILD_TARGET="compile"

src_compile() {
	java-pkg-2_src_compile

	jar -cf ${PN}.jar -C target/classes/ . || die "could not create jar"
}

src_test() {
	echo "junit.jar=$(java-pkg_getjars junit)" >> build.properties
	local deps="jakarta-oro-2.0,commons-digester,commons-beanutils-1.7"
	local deps="${deps},commons-logging,commons-collections,junit"
	eant test -Dskip.download=true \
		-Dgentoo.classpath="$(java-pkg_getjars --build-only --with-dependencies ${deps})"
}

src_install() {
	java-pkg_dojar ${PN}.jar
	dodoc NOTICE.txt RELEASE-NOTES.txt || die
	use doc && java-pkg_dojavadoc dist/docs/apidocs
	use examples && java-pkg_doexamples src/example
	use source && java-pkg_dosrc src/share/*
}
