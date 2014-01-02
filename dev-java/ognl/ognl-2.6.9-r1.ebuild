# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ognl/ognl-2.6.9-r1.ebuild,v 1.3 2014/01/02 15:07:45 tomwij Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Object-Graph Navigation Language; an expression language for getting/setting properties of objects"
HOMEPAGE="http://www.ognl.org/"
SRC_URI="http://www.ognl.org/${PV}/${P}-dist.zip
	https://ognl.dev.java.net/source/browse/*checkout*/ognl/osbuild.xml"

LICENSE="Apache-1.1"
SLOT="2.6"
KEYWORDS="~x86 ~amd64"

RDEPEND=">=virtual/jre-1.4
	dev-java/javacc
	>=dev-java/javassist-3.1"

DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	dev-java/ant-core
	dev-java/ant-contrib
	${RDEPEND}"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cp "${DISTDIR}/osbuild.xml" "${S}/" || die
	cd "${S}/lib/build" || die
	rm -f *.jar || die
	java-pkg_jar-from javacc
	java-pkg_jar-from javassist-3
}

EANT_DOC_TARGET="javadocs"

src_install() {
	java-pkg_newjar build/${P}.jar ${PN}.jar
	use doc && java-pkg_dohtml -r dist/docs/api
	use source && java-pkg_dosrc src/java/*
}
