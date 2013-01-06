# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ognl/ognl-2.6.9-r2.ebuild,v 1.2 2012/12/02 08:33:38 ulm Exp $

EAPI="4"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Object-Graph Navigation Language"
HOMEPAGE="http://www.ognl.org/"
SRC_URI="http://www.ognl.org/${PV}/${P}-dist.zip
	https://ognl.dev.java.net/source/browse/*checkout*/ognl/osbuild.xml"

LICENSE="Apache-1.1"
SLOT="2.6"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.4"
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip"

S="${WORKDIR}"

src_unpack() {
	default
	cp "${DISTDIR}/osbuild.xml" "${S}/" || die
}

java_prepare() {
	find -name '*.jar' -exec rm -v {} + || die
}

EANT_DOC_TARGET="javadocs"

src_install() {
	java-pkg_newjar build/${P}.jar ${PN}.jar
	use doc && java-pkg_dohtml -r dist/docs/api
	use source && java-pkg_dosrc src/java/*
}
