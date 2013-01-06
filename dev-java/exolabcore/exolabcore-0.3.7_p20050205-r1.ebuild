# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/exolabcore/exolabcore-0.3.7_p20050205-r1.ebuild,v 1.5 2008/01/10 22:29:32 caster Exp $

inherit eutils java-pkg-2 java-ant-2

MY_DATE="${PV##*_p}"
MY_PV="${PV%%_p*}"
MY_P="${PN}-${MY_DATE}"

DESCRIPTION="Exolab Build Tools"
HOMEPAGE="http://openjms.cvs.sourceforge.net/openjms/exolabcore/"
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"

LICENSE="Exolab"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc source test"

COMMON_DEP="
	dev-java/cdegroot-db
	dev-java/commons-logging
	=dev-java/jakarta-oro-2.0*"

RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.4
	${COMMON_DEP}
	dev-java/exolabtools
	test? (
		dev-java/commons-cli
		dev-java/log4j
		=dev-java/junit-3.8*
	)
	source? ( app-arch/zip )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}

	cd "${S}/src"
	epatch "${FILESDIR}/${P}-buildfile.patch"
	epatch "${FILESDIR}/0.3.7_p20050205-r1-tests-junit.patch"

	cd "${S}/lib"
	java-pkg_jar-from --build-only exolabtools
	java-pkg_jar-from cdegroot-db-1
	java-pkg_jar-from commons-logging
	java-pkg_jar-from jakarta-oro-2.0 jakarta-oro.jar oro.jar
}

src_compile() {
	cd "${S}/src"
	java-pkg-2_src_compile
}

src_test() {
	cd "${S}/lib"
	java-pkg_jar-from junit
	java-pkg_jar-from commons-cli-1
	java-pkg_jar-from log4j

	cd "${S}/src"
	eant tests
	cd ..
	local deps
	deps="junit,commons-cli-1,log4j,cdegroot-db-1,commons-logging,jakarta-oro-2.0"
	java -cp "build/classes:build/tests:$(java-config -p ${deps})" \
		org.exolab.core.test.CoreTestSuite -execute || die "Tests failed"
}

src_install() {
	java-pkg_newjar dist/${PN}-${MY_PV}.jar ${PN}.jar

	use doc && java-pkg_dojavadoc build/doc/javadoc
	use source && java-pkg_dosrc src/main/*
}
