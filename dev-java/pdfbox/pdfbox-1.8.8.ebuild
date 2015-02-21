# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/pdfbox/pdfbox-1.8.8.ebuild,v 1.1 2015/02/21 14:29:15 monsieurp Exp $
EAPI=5

JAVA_PKG_IUSE="doc source test"
inherit java-pkg-2 java-ant-2

DESCRIPTION="Java library and utilities for working with PDF documents"
HOMEPAGE="http://pdfbox.apache.org/"
ADOBE_FILES="pcfi-2010.08.09.jar"
SRC_URI="mirror://apache/${PN}/${PV}/${P}-src.zip
	http://repo2.maven.org/maven2/com/adobe/pdf/pcfi/2010.08.09/${ADOBE_FILES}"
LICENSE="BSD"
SLOT="1.8"
KEYWORDS="~x86 ~amd64"
IUSE=""

CDEPEND=">=dev-java/bcprov-1.50
	>=dev-java/bcmail-1.45
	>=dev-java/commons-logging-1.1.1:0
	dev-java/icu4j:4
	dev-java/junit:4"
RDEPEND=">=virtual/jre-1.7
	${CDEPEND}"
DEPEND=">=virtual/jdk-1.7
	app-arch/unzip
	test? (
		dev-java/ant-junit:0 )
	${CDEPEND}"

S="${WORKDIR}/${P}/${PN}"

JAVA_ANT_REWRITE_CLASSPATH="yes"

EANT_GENTOO_CLASSPATH="bcprov,bcmail-1.45,commons-logging,junit-4,icu4j-4"
EANT_BUILD_TARGET="pdfbox.package"
WANT_ANT_TASKS="ant-nodeps"

EANT_TEST_GENTOO_CLASSPATH="ant-junit,junit-4"
EANT_TEST_TARGET="test"

src_unpack() {
	unpack ${A}
}

java_prepare() {
	# Correct version number in build.xml. 
	# Silly typo from upstream (version mismatch) but as a result,
	# the generated jar bears version 1.8.7 instead of 1.8.8 :[
	epatch "${FILESDIR}"/${P}-build.xml.patch
	mkdir -v download external
	ln -s "${DISTDIR}/${ADOBE_FILES}" download
}

src_test() {
	# For some reason that I have YET to figure out, 
	# running the junit tests delete the jar file (!?)
	# (well I guess everything inside target/*)

	# So let's move our precious jar to another dir
	mv target/${P}.jar ${P}.jar

	# TODO: not all tests pass; investigate why. 
	# (is it our business or upstream's?)
	java-pkg-2_src_test
}

src_install() {
	java-pkg_newjar ${P}.jar ${PN}.jar

	if use doc; then
		java-pkg_dojavadoc target/site/apidocs
	fi

	if use source; then
		java-pkg_dosrc src/main/java/org
	fi
}
