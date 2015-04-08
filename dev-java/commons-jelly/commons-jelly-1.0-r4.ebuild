# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-jelly/commons-jelly-1.0-r4.ebuild,v 1.3 2010/05/22 20:06:49 ken69267 Exp $

EAPI=2

inherit java-pkg-2 java-ant-2 eutils

MY_P="${P}-src"
DESCRIPTION="A Java and XML based scripting and processing engine"
HOMEPAGE="http://commons.apache.org/jelly/"
SRC_URI="mirror://apache/jakarta/commons/jelly/source/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="1"
KEYWORDS="amd64 x86"
IUSE="doc test source"

RDEPEND=">=virtual/jre-1.4
	java-virtuals/servlet-api:2.3
	dev-java/commons-cli:1
	dev-java/commons-lang:0
	dev-java/commons-discovery:0
	dev-java/forehead:0
	dev-java/jakarta-jstl:0
	dev-java/commons-jexl:1.0
	dev-java/commons-beanutils:1.7
	dev-java/commons-collections:0
	dev-java/dom4j:1
	dev-java/jaxen:1.1
	>=dev-java/xerces-2.7:2
	dev-java/junit:0
	dev-java/commons-logging:0"

DEPEND=">=virtual/jdk-1.4
	test? ( dev-java/ant-junit )
	${RDEPEND}"

S=${WORKDIR}/${MY_P}

java_prepare() {
	# disables dependency fetching, and remove tests as a dependency of jar
	epatch "${FILESDIR}/${P}-gentoo.patch"

	mkdir -p "${S}/lib"
	cd "${S}/lib"
	java-pkg_jar-from --virtual servlet-api-2.3
	java-pkg_jar-from commons-cli-1,commons-lang
	java-pkg_jar-from commons-discovery,forehead,jakarta-jstl,commons-jexl-1.0
	java-pkg_jar-from commons-beanutils-1.7,commons-collections
	java-pkg_jar-from dom4j-1,jaxen-1.1,xerces-2
	java-pkg_jar-from commons-logging,junit
}

EANT_EXTRA_ARGS="-Dlibdir=lib"

src_test() {
	ANT_TASKS="ant-junit" eant test -Dlibdir=lib
}

src_install() {
	java-pkg_newjar target/${P}.jar ${PN}.jar

	dodoc NOTICE.txt README.txt RELEASE-NOTES.txt || die

	use doc && java-pkg_dojavadoc dist/docs/api
	use source && java-pkg_dosrc src/java/*
}
