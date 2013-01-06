# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/java-wakeonlan/java-wakeonlan-1.0.0.ebuild,v 1.3 2007/11/04 11:16:10 opfer Exp $

JAVA_PKG_IUSE="doc source"
inherit java-pkg-2 java-ant-2

DESCRIPTION="A wakeonlan commandline tool and Java library"
SRC_URI="http://www.moldaner.de/wakeonlan/download/wakeonlan-${PV}.zip"
HOMEPAGE="http://www.moldaner.de/wakeonlan/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="test"

COMMON_DEPEND="dev-java/jsap"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEPEND}"
DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	app-arch/unzip
	test? ( =dev-java/junit-3.8* )
	${COMMON_DEPEND}"

S=${WORKDIR}/wakeonlan-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	find -name "*.jar" | xargs rm -v
	java-ant_rewrite-classpath
}

src_compile() {
	eant deploy -Dgentoo.classpath=$(java-pkg_getjars jsap):$(java-pkg_getjars --build-only junit) $(use_doc)
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
