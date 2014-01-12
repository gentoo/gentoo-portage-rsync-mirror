# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jackson/jackson-2.3.1.ebuild,v 1.1 2014/01/12 18:19:01 ercpe Exp $

EAPI="5"

JAVA_PKG_IUSE="doc source test"

inherit java-pkg-2 java-ant-2

DESCRIPTION="High-performance JSON processor"
HOMEPAGE="http://jackson.codehaus.org"
SRC_URI="https://github.com/FasterXML/${PN}-core/archive/${PN}-core-${PV}.tar.gz"

LICENSE="|| ( Apache-2.0 LGPL-2.1 )"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5
	test? (
		dev-java/ant-junit4
		dev-java/junit:4
	)
"
JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_TEST_GENTOO_CLASSPATH="junit-4"

S="${WORKDIR}/${PN}-core-${PN}-core-${PV}"

java_prepare() {
	cp "${FILESDIR}"/${PV}-build.xml "${S}"/build.xml || die

	sed -e 's:@package@:com.fasterxml.jackson.core.json:g' \
		-e "s:@projectversion@:${PV}:g" \
		-e 's:@projectgroupid@:com.fasterxml.jackson.core:g' \
		-e 's:@projectartifactid@:jackson-core:g' \
		"${S}/src/main/java/com/fasterxml/jackson/core/json/PackageVersion.java.in" \
		> "${S}/src/main/java/com/fasterxml/jackson/core/json/PackageVersion.java" || die
}

src_install() {
	java-pkg_dojar target/${PN}-core.jar

	use doc && java-pkg_dojavadoc target/site/apidocs/
	use source && java-pkg_dosrc src/main/java/*
}

src_test() {
	EANT_TASKS="ant-junit4"
	java-pkg-2_src_test
}