# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-digester/commons-digester-3.2.ebuild,v 1.3 2014/08/10 20:10:27 slyfox Exp $

EAPI="5"

# See bug #480758.
RESTRICT="test"
JAVA_PKG_IUSE="doc examples source" # test

inherit eutils java-pkg-2 java-ant-2

MY_P="${PN}3-${PV}-src"

DESCRIPTION="Reads XML configuration files to provide initialization of various Java objects within the system"
HOMEPAGE="http://commons.apache.org/digester/"
SRC_URI="mirror://apache/commons/digester/source/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="3.2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"

RDEPEND=">=virtual/jre-1.5
	dev-java/commons-beanutils:1.7
	>=dev-java/commons-logging-1.0.2:0
	dev-java/cglib:2.2"

DEPEND=">=virtual/jdk-1.5
	${RDEPEND}"
#	test? (
#		dev-java/junit:4
#		dev-java/ant-junit
#	)

S="${WORKDIR}/${MY_P}"

JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_GENTOO_CLASSPATH="commons-beanutils-1.7,commons-logging,cglib-2.2"
EANT_TEST_GENTOO_CLASSPATH="${EANT_GENTOO_CLASSPATH},junit-4"

java_prepare() {
	cp "${FILESDIR}"/${PN}-2.1-build.xml build.xml || die
}

src_test() {
	java-pkg_jar-from --build-only junit-4

	ANT_TASKS="ant-junit" eant \
		-Djunit.jar="$(java-pkg_getjar --build-only junit-4 junit.jar)" test
}

src_install() {
	java-pkg_newjar target/${PN}.jar

	dodoc RELEASE-NOTES.txt

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/org
	use examples && java-pkg_doexamples src/examples
}
