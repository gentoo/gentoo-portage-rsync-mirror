# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xmlrpc/xmlrpc-2.0.1.ebuild,v 1.5 2007/11/03 01:52:59 pylon Exp $

JAVA_PKG_IUSE="doc examples source test"
inherit java-pkg-2 java-ant-2

DESCRIPTION="Apache XML-RPC is a Java implementation of XML-RPC"
HOMEPAGE="http://ws.apache.org/xmlrpc/"
SRC_URI="mirror://apache/ws/xmlrpc/sources/${P}-src.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ppc x86"
CDEPEND="=dev-java/commons-httpclient-3*
	dev-java/commons-codec"
DEPEND=">=virtual/jdk-1.4
	test? ( dev-java/ant-junit =dev-java/junit-3* )
	${CDEPEND}"
RDEPEND=">=virtual/jre-1.4
	${CDEPEND}"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	# add gentoo.classpath and haltonfailure to <junit>
	epatch "${FILESDIR}/${P}.build.xml.patch"
	java-ant_ignore-system-classes
	java-ant_rewrite-classpath

	mkdir lib && cd lib
	# stupid <available> check
	use test && java-pkg_jar-from --build-only junit junit.jar junit-3.8.1.jar
}

EANT_EXTRA_ARGS="-Dversion=${PV} -Dhave.deps=true"
EANT_BUILD_TARGET="jar"
EANT_DOC_TARGET="javadocs"
EANT_GENTOO_CLASSPATH="commons-httpclient-3,commons-codec"

src_test() {
	ANT_TASKS="ant-junit" eant ${EANT_EXTRA_ARGS} test
}

src_install() {
	java-pkg_newjar target/xmlrpc-${PV}.jar ${PN}.jar
	java-pkg_newjar target/xmlrpc-${PV}-applet.jar ${PN}-applet.jar

	newdoc README.txt README

	use doc && java-pkg_dojavadoc target/docs/api
	use examples && java-pkg_doexamples examples
	use source && java-pkg_dosrc src/java/*
}

pkg_postinst() {
	elog "This port does not currently build Servlet and/or SSL extensions. If"
	elog "you need them, please file a bug or contact java@gentoo.org."
}
