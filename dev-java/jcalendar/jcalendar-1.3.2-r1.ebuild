# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jcalendar/jcalendar-1.3.2-r1.ebuild,v 1.6 2009/07/05 21:19:41 aballier Exp $

EAPI=1
JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Java date chooser bean for graphically picking a date."
SRC_URI="http://www.toedter.com/download/${P}.zip"
HOMEPAGE="http://www.toedter.com/en/jcalendar/"
LICENSE="LGPL-2.1"
SLOT="1.2"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE=""
COMMON_DEPEND="dev-java/jgoodies-looks:2.0"
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
	java-pkg_jar-from jgoodies-looks-2.0
}

EANT_BUILD_XML="src/build.xml"
EANT_DOC_TARGET="dist"

src_install() {
	java-pkg_newjar lib/${P}.jar

	dodoc readme.txt || die
	# Other stuff besides javadoc
	use doc && java-pkg_dohtml -r doc/*
	use source && java-pkg_dosrc src/com
}
