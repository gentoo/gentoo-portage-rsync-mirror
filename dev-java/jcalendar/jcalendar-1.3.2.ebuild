# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jcalendar/jcalendar-1.3.2.ebuild,v 1.6 2007/06/07 21:54:21 wltjr Exp $

JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Java date chooser bean for graphically picking a date."
SRC_URI="http://www.toedter.com/download/${P}.zip"
HOMEPAGE="http://www.toedter.com/en/jcalendar/"
LICENSE="LGPL-2.1"
SLOT="1.2"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE=""
COMMON_DEPEND="=dev-java/jgoodies-looks-1.2*"
RDEPEND=">=virtual/jdk-1.4
	${COMMON_DEPEND}"
DEPEND=">=virtual/jdk-1.4
	>=app-arch/unzip-5.50-r1
	${COMMON_DEPEND}"

S=${WORKDIR}

# NOTE: build.xml contains no tests

src_unpack() {
	unpack ${A}

	cd "${S}/lib"
	rm -v *.jar || die
	java-pkg_jar-from jgoodies-looks-1.2 looks.jar looks-1.2.2.jar
}

src_compile() {
	# 'javadoc' target removes jcalendar.jar so we must call 'dist' instead
	# to get both jcalendar.jar and javadoc
	local antflags=""
	if use doc ; then
		antflags="dist"
	else
		antflags="jar"
	fi
	eant -f src/build.xml ${antflags}
}

src_install() {
	java-pkg_newjar lib/${P}.jar

	dodoc readme.txt || die
	use doc && java-pkg_dohtml -r doc/*
	use source && java-pkg_dosrc src/com
}
