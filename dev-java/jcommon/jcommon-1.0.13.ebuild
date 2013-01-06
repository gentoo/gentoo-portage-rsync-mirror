# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jcommon/jcommon-1.0.13.ebuild,v 1.3 2008/10/25 17:10:51 nixnut Exp $

EAPI=1
JAVA_PKG_IUSE="doc source test"

inherit java-pkg-2 java-ant-2 versionator

DESCRIPTION="JCommon is a collection of useful classes used by JFreeChart, JFreeReport and other projects."
HOMEPAGE="http://www.jfree.org/jcommon"
MY_P=${PN}-$(replace_version_separator 3 -)
SRC_URI="mirror://sourceforge/jfreechart/${MY_P}.tar.gz"
LICENSE="LGPL-2"
SLOT="1.0"
KEYWORDS="amd64 ppc x86"
IUSE="debug"
DEPEND=">=virtual/jdk-1.4
		test? ( dev-java/junit:0 )"
RDEPEND=">=virtual/jdk-1.4"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -v *.jar "${S}"/lib/*.jar || die
}

src_compile() {
	if ! use debug; then
		antflags="-Dbuild.debug=false -Dbuild.optimize=true"
	fi
	eant -f ant/build.xml compile $(use_doc) $antflags
}

src_test() {
	java-pkg_jar-from  --into lib junit
	eant -f ant/build.xml compile-junit-tests
	ejunit -cp "./lib/jcommon-${PV}-junit.jar:$(java-pkg_getjars junit)" \
		org.jfree.junit.JCommonTestSuite
}

src_install() {
	java-pkg_newjar ${P}.jar ${PN}.jar
	dodoc README.txt || die
	use doc && java-pkg_dojavadoc javadoc
	use source && java-pkg_dosrc source/com source/org
}
