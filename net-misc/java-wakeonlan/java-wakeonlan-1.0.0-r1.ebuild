# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/java-wakeonlan/java-wakeonlan-1.0.0-r1.ebuild,v 1.4 2011/12/04 11:45:11 hwoarang Exp $

EAPI="1"
JAVA_PKG_IUSE="doc source"
inherit java-pkg-2 java-ant-2

DESCRIPTION="A wakeonlan commandline tool and Java library"
SRC_URI="http://www.moldaner.de/wakeonlan/download/wakeonlan-${PV}.zip"
HOMEPAGE="http://www.moldaner.de/wakeonlan/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="test"

COMMON_DEPEND="dev-java/jsap:0"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEPEND}"
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	test? ( dev-java/junit:0 )
	${COMMON_DEPEND}"

S=${WORKDIR}/wakeonlan-${PV}

EANT_GENTOO_CLASSPATH="jsap"
EANT_BUILD_TARGET="deploy"
JAVA_ANT_CLASSPATH_TAGS+=" javadoc"

src_unpack() {
	unpack ${A}
	cd "${S}"
	find -name "*.jar" | xargs rm -v
	epatch "${FILESDIR}"/${P}-build.xml.patch
	java-ant_rewrite-classpath
}

src_test() {
	ANT_TASKS="ant-junit" eant test -Dgentoo.classpath=$(java-pkg_getjars jsap):$(java-pkg_getjars --build-only junit)
}

src_install() {
	java-pkg_dojar deploy/wakeonlan.jar
	java-pkg_dolauncher ${PN} --main wol.WakeOnLan
	dodoc doc/README
	use doc && java-pkg_dojavadoc deploy/doc/javadoc
	use source && java-pkg_dosrc src/wol
}
