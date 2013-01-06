# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/odfdom/odfdom-0.8.6.ebuild,v 1.2 2012/08/26 14:04:54 thev00d00 Exp $

EAPI="3"

JAVA_PKG_IUSE="doc source test"

inherit java-pkg-2 java-ant-2

DESCRIPTION="The ODFDOM reference implementation, written in Java."
HOMEPAGE="http://odftoolkit.org/projects/odfdom"
SRC_URI="http://odftoolkit.org/projects/odfdom/downloads/download/current-version%252F${P}-sources.zip -> ${P}-sources.zip"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc-aix ~hppa-hpux ~ia64-hpux ~x86-linux ~sparc-solaris ~x86-solaris"
IUSE=""

CDEPEND="dev-java/xerces:2
	dev-java/xml-commons-external:1.3"

RDEPEND=">=virtual/jre-1.5
	${CDEPEND}"
DEPEND=">=virtual/jdk-1.5
	${CDEPEND}
	test? (
		dev-java/ant-junit4:0
		dev-java/hamcrest-core:0
		dev-java/junit:4
	)"

S="${WORKDIR}/${P}-sources"

src_prepare() {
	cp "${FILESDIR}/build-${PV}.xml" build.xml || die

	mkdir lib || die
	java-pkg_jar-from --into lib xerces-2 xercesImpl.jar xercesImpl-2.9.1.jar
	java-pkg_jar-from --into lib xml-commons-external-1.3 xml-apis.jar \
		xml-apis-1.3.04.jar
}

EANT_BUILD_TARGET="package"
EANT_JAVADOC_TARGET="javadoc"
EANT_EXTRA_ARGS="-Dmaven.test.skip=true"

src_test() {
	java-pkg_jar-from --into lib junit-4 junit.jar junit-4.5.jar
	java-pkg_jar-from --into lib hamcrest-core
	ANT_TASKS="ant-junit" eant test
}

src_install() {
	java-pkg_dojar target/odfdom.jar

	dodoc README.txt LICENSE.txt || die
	use doc && java-pkg_dojavadoc target/site/apidocs
}
