# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/joda-convert/joda-convert-1.3.1.ebuild,v 1.2 2013/05/09 15:39:54 tomwij Exp $

EAPI="5"

JAVA_PKG_IUSE="doc source test"
JAVA_ANT_REWRITE_CLASSPATH="true"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Java library for conversion between Object and String."
HOMEPAGE="http://joda-convert.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-dist.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=virtual/jdk-1.5
	test? (
		dev-java/junit:4
		dev-java/ant-junit:0
		dev-java/hamcrest-core:0
	)"
RDEPEND=">=virtual/jre-1.5"

java_prepare() {
	cp "${FILESDIR}"/${P}-build.xml build.xml || die
}

EANT_TEST_GENTOO_CLASSPATH="junit-4"

src_test() {
	java-pkg-2_src_test
}

src_install() {
	java-pkg_newjar target/${P}.jar ${PN}.jar
	dodoc NOTICE.txt RELEASE-NOTES.txt

	use doc && java-pkg_dojavadoc doc/api
	use source && java-pkg_dosrc src/main/java/*
}
