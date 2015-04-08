# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/antenna/antenna-1.0.2-r1.ebuild,v 1.1 2012/01/13 14:29:39 sera Exp $

EAPI=2

JAVA_PKG_IUSE="doc examples source"

inherit java-pkg-2 java-ant-2 eutils

MY_P=${DISTDIR}/${PN}-src-${PV}.zip

DESCRIPTION="Ant task for J2ME"
HOMEPAGE="http://antenna.sourceforge.net/"
SRC_URI="mirror://sourceforge/antenna/${PN}-src-${PV}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEP="dev-java/ant-core:0
	dev-java/antlr:0
	java-virtuals/servlet-api:2.4"
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"

S="${WORKDIR}"

JAVA_PKG_BSFIX="off"

src_unpack() {
	default
	unzip -n lib/preprocessor-src-1.1.zip
}

java_prepare() {
	rm -rf lib
	java-ant_bsfix_one build.xml
	java-ant_rewrite-classpath build.xml
}

src_compile() {
	local cp="ant-core,antlr,servlet-api-2.4"
	EANT_GENTOO_CLASSPATH="${cp}" \
		EANT_BUILD_TARGET="init compile package" \
		EANT_DOC_TARGET="" java-pkg-2_src_compile
	if use doc; then
		javadoc -encoding latin1 -d api $(find src -name "*.java") \
			-classpath $(java-pkg_getjars "${cp}") \
			|| die "javadoc failed"
	fi
}

src_install() {
	java-pkg_newjar dist/${PN}-bin-${PV}.jar
	java-pkg_register-ant-task

	if use doc; then
		java-pkg_dohtml doc/*
		java-pkg_dojavadoc api
	fi
	use source && java-pkg_dosrc src/*
	use examples && java-pkg_doexamples samples
}
