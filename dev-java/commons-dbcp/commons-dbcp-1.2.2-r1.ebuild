# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-dbcp/commons-dbcp-1.2.2-r1.ebuild,v 1.6 2010/11/14 00:40:34 caster Exp $

EAPI=2
JAVA_PKG_IUSE="doc source test"
JAVA_PKG_WANT_BOOTCLASSPATH="1.5"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Jakarta component providing database connection pooling API"
HOMEPAGE="http://commons.apache.org/dbcp/"
SRC_URI="http://archive.apache.org/dist/commons/dbcp/source/${P}-src.tar.gz"
COMMON_DEP=">=dev-java/commons-pool-1.3"
RDEPEND=">=virtual/jre-1.5
		${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
		test? (
			dev-java/junit:0
			www-servers/tomcat:6
			dev-java/xerces:2
		)
		${COMMON_DEP}"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

S="${WORKDIR}/${P}-src"

java_prepare() {
	echo "commons-pool.jar=$(java-pkg_getjars commons-pool)" >> build.properties
	rm -v *.jar || die
	java-ant_rewrite-bootclasspath 1.5
}

EANT_BUILD_TARGET="build-jar"

src_test() {
	eant test -Djunit.jar="$(java-pkg_getjars junit)" \
		-Dnaming-java.jar="$(java-pkg_getjar tomcat-6 catalina.jar)" \
		-Dxerces.jar="$(java-pkg_getjars xerces-2)"
}

src_install() {
	java-pkg_dojar dist/${PN}*.jar || die "Unable to install"
	dodoc README.txt RELEASE-NOTES.txt || die
	use doc && java-pkg_dojavadoc dist/docs/api
	use source && java-pkg_dosrc src/java/*
}
