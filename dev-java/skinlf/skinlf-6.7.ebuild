# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/skinlf/skinlf-6.7.ebuild,v 1.4 2012/12/30 16:53:57 ulm Exp $

EAPI="1"

JAVA_PKG_IUSE="examples source"
WANT_ANT_TASKS="ant-nodeps"
inherit eutils java-pkg-2 java-ant-2

MY_P="${P}-20060722"

DESCRIPTION="Skin Look and Feel - Skinning Engine for the Swing toolkit"
HOMEPAGE="http://${PN}.l2fprod.com/"
SRC_URI="https://${PN}.dev.java.net/files/documents/66/37801/${MY_P}.zip"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="dev-java/laf-plugin:0
	dev-java/xalan"
RDEPEND=">=virtual/jre-1.4
	${CDEPEND}"
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	${CDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-image-utils-without-jimi.patch"

	cp "${FILESDIR}/${P}-build.xml" build.xml
	cp "${FILESDIR}/${P}-common.xml" common.xml

	cd lib
	# assert_built_jar_equals is your friend, upstream your enemy
	unzip ${PN}.jar '*.gif' '*.template' -d ../src || die
	rm -v *.jar

	java-pkg_jar-from xalan,laf-plugin
}

src_install() {
	java-pkg_dojar build/${PN}.jar
	# laf-plugin.jar is referenced in manifest's Class-Path
	# doesn't work without it due to class loader trickery
	# upstream solved this by absorbing laf-plugin in own jar...
	java-pkg_dojar lib/laf-plugin.jar

	use examples && java-pkg_doexamples src/examples
	use source && java-pkg_dosrc src/com src/*.java

	dodoc CHANGES README || die
}
