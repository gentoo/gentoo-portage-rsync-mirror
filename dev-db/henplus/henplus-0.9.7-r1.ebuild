# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/henplus/henplus-0.9.7-r1.ebuild,v 1.5 2007/07/13 06:38:59 mr_bones_ Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 eutils java-ant-2

DESCRIPTION="Java-based multisession SQL shell for databases with JDBC support."
HOMEPAGE="http://henplus.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

COMMON_DEPEND="=dev-java/commons-cli-1*
	dev-java/libreadline-java"
RDEPEND=">=virtual/jre-1.3
	${COMMON_DEPEND}"
DEPEND=">=virtual/jdk-1.3
	${COMMON_DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-build.xml.patch"

	cd lib
	rm -v *.jar build/*.jar || die
	java-pkg_jar-from commons-cli-1 commons-cli.jar
	java-pkg_jar-from libreadline-java libreadline-java.jar
}

src_install () {
	java-pkg_dojar "build/${PN}.jar"

	java-pkg_dolauncher ${PN} -pre "${FILESDIR}/${PN}.pre" \
		--main henplus.HenPlus

	dodoc README || die
	dohtml doc/HenPlus.html || die
	use doc && java-pkg_dojavadoc javadoc/api

	use source && java-pkg_dosrc "src/${PN}"
}
