# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/mg4j/mg4j-0.9.1-r1.ebuild,v 1.4 2008/03/02 14:36:10 philantrop Exp $

JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="A free Java implementation of inverted-index compression technique."
SRC_URI="http://mg4j.dsi.unimi.it/${P}-src.tar.gz"
HOMEPAGE="http://mg4j.dsi.unimi.it"
LICENSE="LGPL-2.1"
SLOT="0.9"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

COMMON_DEP="=dev-java/fastutil-4.3*
	>=dev-java/jal-20031117
	dev-java/colt
	=dev-java/java-getopt-1.0*
	=dev-java/libreadline-java-0.8*"

RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"

DEPEND=">=virtual/jdk-1.4
	>=dev-java/javacc-3
	${COMMON_DEP}"

src_unpack() {

	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/mg4j-build.patch"

	mkdir lib/ && cd lib/
	java-pkg_jar-from colt
	java-pkg_jar-from fastutil-4.3
	java-pkg_jar-from jal
	java-pkg_jar-from libreadline-java
	java-pkg_jar-from java-getopt-1

}

src_install() {

	java-pkg_newjar ${P}.jar

	use doc && java-pkg_dojavadoc docs
	use source && java-pkg_dosrc java/it

}
