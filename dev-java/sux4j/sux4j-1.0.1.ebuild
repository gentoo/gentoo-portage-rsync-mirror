# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sux4j/sux4j-1.0.1.ebuild,v 1.3 2008/04/21 18:20:11 mr_bones_ Exp $

EAPI="1"
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Sux: Implementing Succinct Data Structures"
HOMEPAGE="http://sux.dsi.unimi.it/"
SRC_URI="http://sux.dsi.unimi.it/${P}-src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"

COMMON_DEP=">=dev-java/fastutil-5.1.3
			dev-java/commons-io:1
			dev-java/colt
			dev-java/dsiutils
			dev-java/log4j
			dev-java/commons-collections
			dev-java/commons-configuration
			dev-java/jsap
			dev-java/commons-lang:2.1
			=dev-java/junit-3.8*"

RDEPEND=">=virtual/jre-1.5
		${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
		test? ( dev-java/emma )
		app-arch/unzip
		${COMMON_DEP}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	java-ant_rewrite-classpath
}

EANT_GENTOO_CLASSPATH="fastutil:5.0,commons-io:1,colt,dsiutils,log4j,commons-collections,commons-configuration,jsap,commons-lang:2.1,junit"

src_install() {
	java-pkg_newjar "${P}.jar"
	use doc && java-pkg_dojavadoc docs
	use source && java-pkg_dosrc src
}
