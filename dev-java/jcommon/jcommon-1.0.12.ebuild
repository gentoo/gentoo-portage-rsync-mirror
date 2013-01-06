# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jcommon/jcommon-1.0.12.ebuild,v 1.5 2008/01/10 23:04:33 caster Exp $

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
		test? ( =dev-java/junit-3.8* )"
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

# Needs X11
RESTRICT="test"

src_test() {
	cd lib/ || die
	java-pkg_jar-from junit
	cd ..
	eant -f ant/build.xml compile-junit-tests
	java -cp "./lib/jcommon-${PV}-junit.jar:$(java-pkg_getjars junit)" \
		junit.textui.TestRunner \
		-Djava.awt.headless=true \
		org.jfree.junit.JCommonTestSuite || die "Tests failed"
}

src_install() {
	java-pkg_newjar ${P}.jar ${PN}.jar
	dodoc README.txt || die
	use doc && java-pkg_dojavadoc javadoc
	use source && java-pkg_dosrc source/com source/org
}
