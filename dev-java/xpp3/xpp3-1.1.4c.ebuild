# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xpp3/xpp3-1.1.4c.ebuild,v 1.9 2012/01/01 15:44:43 sera Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

MY_PV=${PV/m/.M}
MY_P=${PN}-${MY_PV}

DESCRIPTION="An implementation of XMLPULL V1 API."
HOMEPAGE="http://www.extreme.indiana.edu/xgws/xsoap/xpp/mxp1/index.html"
SRC_URI="http://www.extreme.indiana.edu/dist/java-repository/${PN}/distributions/${MY_P}_src.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE="test"

DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	test? ( dev-java/ant-junit )"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack "${A}"
	cd "${S}"
	rm -v *.jar || die
	epatch "${FILESDIR}/${P}-build.xml.patch"
}

src_test() {
	ANT_TASKS="ant-junit" \
		eant -Dgentoo.classpath=$(java-pkg_getjars junit) junit_main
}

src_install() {
	java-pkg_newjar build/${MY_P}.jar ${PN}.jar

	use doc && java-pkg_dojavadoc doc
	use source && java-pkg_dosrc src/java/*
}
