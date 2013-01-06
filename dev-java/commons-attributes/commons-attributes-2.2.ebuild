# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-attributes/commons-attributes-2.2.ebuild,v 1.2 2008/04/05 00:37:20 betelgeuse Exp $

EAPI=1
JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Commons Attributes enables Java programmers to use C#/.Net-style attributes in their code."
HOMEPAGE="http://commons.apache.org/attributes/"
SRC_URI="mirror://apache/commons/attributes/source/${P}-src.tar.gz"

LICENSE="Apache-2.0"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEP="dev-java/xjavadoc
	dev-java/gjdoc
	dev-java/ant-core
	dev-java/qdox:1.6"
DEPEND=">=virtual/jdk-1.4
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	mkdir -p target/lib
	cd target/lib
	java-pkg_jar-from ant-core ant.jar
	java-pkg_jar-from gjdoc
	java-pkg_jar-from qdox-1.6
}

src_install() {
	java-pkg_newjar target/${PN}-api-${PV}.jar ${PN}-api.jar
	java-pkg_newjar target/${PN}-compiler-${PV}.jar ${PN}-compiler.jar

	java-pkg_register-ant-task

	dodoc NOTICE.txt || die
	dohtml README.html || die

	use doc && java-pkg_dojavadoc dist/docs/api
	use source && java-pkg_dosrc api/src/java/org compiler/src/java/org
}
