# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jaxme/jaxme-0.3.1-r4.ebuild,v 1.6 2012/01/01 18:08:18 sera Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2 eutils

MY_PN=ws-${PN}
MY_P=${MY_PN}-${PV}
DESCRIPTION="JaxMe 2 is an open source implementation of JAXB, the specification for Java/XML binding."
HOMEPAGE="http://ws.apache.org/jaxme/index.html"
SRC_URI="mirror://apache/ws/${PN}/source/${MY_P}-src.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

COMMON_DEP="
	>=dev-java/xerces-2.7
	=dev-java/junit-3.8*
	dev-java/gnu-crypto
	>=dev-java/log4j-1.2.8
	dev-java/ant-core
	dev-java/xmldb"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
# FIXME doesn't like to compile with Java 1.6
# test? ( dev-java/ant-junit )
DEPEND="|| (
		=virtual/jdk-1.5*
		=virtual/jdk-1.4*
	)
	${COMMON_DEP}"

S="${WORKDIR}/${MY_P}"

# We do it later
JAVA_PKG_BSFIX="off"

# They fail atm. Our version is outdated so let's see how new versions do
RESTRICT="test"

src_unpack() {
	unpack ${A}

	cd "${S}"
	# Fix the build.xml so we can build jars and javadoc easily
	epatch "${FILESDIR}/${P}-gentoo.patch"
	# Use gnu-crypto instead of com.sun.* stuff
	epatch "${FILESDIR}/${P}-base64.diff"

	java-pkg_filter-compiler jikes
	rm -v src/documentation/lib/*.jar || die
	cd "${S}/prerequisites"
	rm -v *.jar || die
	java-pkg_jarfrom junit
	java-pkg_jarfrom log4j log4j.jar log4j-1.2.8.jar
	java-pkg_jarfrom gnu-crypto gnu-crypto.jar
	java-pkg_jarfrom xerces-2
	java-pkg_jarfrom xmldb xmldb-api.jar xmldb-api-20021118.jar
	java-pkg_jarfrom xmldb xmldb-api-sdk.jar xmldb-api-sdk-20021118.jar

	# Bad build system, should be fixed to use properties
	java-pkg_jarfrom ant-core ant.jar ant-1.5.4.jar
	java-pkg_jarfrom ant-core ant.jar ant.jar

	# Special case: jaxme uses build<foo>.xml files, so rewriting them by hand
	# is better:
	cd "${S}"
	for i in build*.xml src/webapp/build.xml src/test/jaxb/build.xml; do
		java-ant_bsfix_one "${i}"
	done
}

EANT_EXTRA_ARGS="-Dbuild.apidocs=dist/doc/api"
EANT_TEST_ANT_TASKS="hsqldb"

src_install() {
	java-pkg_dojar dist/*.jar

	dodoc NOTICE || die

	if use doc; then
		java-pkg_dojavadoc dist/doc/api
		java-pkg_dohtml src/documentation/manual
	fi
	use source && java-pkg_dosrc src/*/*
}
