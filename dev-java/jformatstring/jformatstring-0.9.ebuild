# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jformatstring/jformatstring-0.9.ebuild,v 1.1 2011/04/10 17:04:12 nerdboy Exp $

EAPI=2

JAVA_PKG_IUSE="doc source test"
inherit eutils java-pkg-2 java-ant-2

MY_PN="jFormatString"
DESCRIPTION="Compile time checking for Java Format Strings"
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="https://jformatstring.dev.java.net/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND=">=virtual/jdk-1.5
	app-arch/unzip
	dev-java/junit"
RDEPEND=">=virtual/jre-1.5"

JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_BUILD_TARGET="build"
EANT_DOC_TARGET="javadoc"
EANT_GENTOO_CLASSPATH="ant-core"

src_compile() {
#	cd "${S}"
	mkdir lib
	cd lib/
	java-pkg_jar-from junit-4
	# if the above gets done in java_prepare() instead, then the lib
	# dir gets wiped out by the time it gets here.  weird...

	cd ../
	eant build -Dproject.name=${MY_PN} -Dpackage.name=${MY_PN} -Dpkg="*"

	# generate javadoc
	if use doc ; then
#		cd "${S}"/${MY_PN}
		mkdir javadoc
		javadoc -d javadoc -sourcepath $(find src/ -name "*.java") \
			-classpath $(java-pkg_getjars ant-core,junit-4) \
			-subpackages junit:java \
			|| die "Javadoc creation failed"
	fi
}

src_test() {
	ANT_TASKS="ant-nodeps ant-junit" eant runjunit
}

src_install() {
#	cd "${S}"/${MY_PN}
	java-pkg_dojar build/${MY_PN}.jar

	use source && java-pkg_dosrc src/java src/junit

	use doc && java-pkg_dojavadoc javadoc
}
