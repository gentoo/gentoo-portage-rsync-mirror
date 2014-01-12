# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jackson-databind/jackson-databind-2.3.1.ebuild,v 1.1 2014/01/12 18:53:43 ercpe Exp $

EAPI="5"

JAVA_PKG_IUSE="source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="High-performance JSON processor"
HOMEPAGE="http://jackson.codehaus.org"
SRC_URI="https://github.com/FasterXML/${PN}/archive/${PN}-${PV}.tar.gz"

LICENSE="|| ( Apache-2.0 LGPL-2.1 )"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="dev-java/jackson:${SLOT}
	dev-java/jackson-annotations:${SLOT}"
RDEPEND=">=virtual/jre-1.5
	${CDEPEND}"
DEPEND=">=virtual/jdk-1.5
	${CDEPEND}"

JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_GENTOO_CLASSPATH="jackson-${SLOT},jackson-annotations-${SLOT}"
EANT_TEST_GENTOO_CLASSPATH="${EANT_GENTOO_CLASSPATH},junit-4,cglib-2.2,groovy"

S="${WORKDIR}/${PN}-${PN}-${PV}"

java_prepare() {
	cp "${FILESDIR}"/${PV}-build.xml "${S}"/build.xml || die

	sed -e 's:@package@:com.fasterxml.jackson.databind.cfg:g' \
		-e "s:@projectversion@:${PV}:g" \
		-e 's:@projectgroupid@:com.fasterxml.jackson.core:g' \
		-e 's:@projectartifactid@:jackson-databind:g' \
		"${S}/src/main/java/com/fasterxml/jackson/databind/cfg/PackageVersion.java.in" \
		> "${S}/src/main/java/com/fasterxml/jackson/databind/cfg/PackageVersion.java" || die
}

src_install() {
	java-pkg_dojar target/${PN}.jar
	use source && java-pkg_dosrc src/main/java/*
}
