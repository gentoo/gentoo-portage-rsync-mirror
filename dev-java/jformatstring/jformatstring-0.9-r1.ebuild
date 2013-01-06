# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jformatstring/jformatstring-0.9-r1.ebuild,v 1.1 2012/06/17 15:20:15 sera Exp $

EAPI=4

JAVA_PKG_IUSE="doc source test"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Compile time checking for Java Format Strings"
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="https://jformatstring.dev.java.net/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5
	app-arch/unzip
	test? (
		dev-java/ant-junit:0
		dev-java/junit:4
	)"

java_prepare() {
	# Upstreams is aargh!
	cp "${FILESDIR}"/build.xml . || die
}

JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_TEST_GENTOO_CLASSPATH="junit:4"

src_test() {
	java-pkg-2_src_test
}

src_install() {
	# Rename to match old name it was installed under
	# should be fixed on slot bump
	java-pkg_newjar build/${PN}.jar jFormatString.jar

	use source && java-pkg_dosrc src/java/*
	use doc && java-pkg_dojavadoc build/javadoc
}
