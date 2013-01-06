# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/dsiutils/dsiutils-1.0.10-r1.ebuild,v 1.5 2012/04/13 18:05:15 ulm Exp $

EAPI="2"
JAVA_PKG_IUSE="doc source test"
JAVA_ANT_CLASSPATH_TAGS="javac xjavac junit"

inherit java-pkg-2 java-ant-2

DESCRIPTION="A Mish Mash of classes that were initially distributed with mg4j (amount others)."
HOMEPAGE="http://dsiutils.dsi.unimi.it/"
SRC_URI="http://dsiutils.dsi.unimi.it/${P}-src.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"

IUSE=""

COMMON_DEP="dev-java/commons-io:1
			dev-java/jsap:0
			dev-java/log4j:0
			dev-java/commons-collections:0
			dev-java/colt:0
			dev-java/fastutil:5.0
			dev-java/commons-configuration:0
			dev-java/commons-lang:2.1
			dev-java/junit:0"

RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	test? (
		dev-java/emma:0
		dev-java/ant-junit:0
		dev-java/ant-trax:0
	)
	${COMMON_DEP}"

java_prepare() {
	java-ant_rewrite-classpath
}

JAVA_ANT_REWRITE_CLASSPATH="1"
EANT_GENTOO_CLASSPATH="commons-io-1,jsap,log4j,commons-collections,colt,fastutil-5.0,commons-configuration,commons-lang-2.1,junit"

src_install() {
	java-pkg_newjar "${P}.jar"
	use doc && java-pkg_dojavadoc docs
	use source && java-pkg_dosrc src
}

src_test() {
	ANT_TASKS="ant-junit,ant-trax" eant \
		-Djar.base=/usr/share/emma/lib \
		-Dgentoo.classpath="$(java-pkg_getjars --build-only ${EANT_GENTOO_CLASSPATH})" \
		junit
}
