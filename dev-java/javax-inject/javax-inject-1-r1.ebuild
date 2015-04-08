# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/javax-inject/javax-inject-1-r1.ebuild,v 1.2 2013/05/30 08:59:38 tomwij Exp $

EAPI="5"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

MY_P=${PN/-/.}-${PV}

DESCRIPTION="Dependency injection for Java (JSR-330)"
HOMEPAGE="http://code.google.com/p/atinject/"
SRC_URI="http://atinject.googlecode.com/files/${MY_P}-bundle.jar"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=virtual/jdk-1.5
	app-arch/unzip"

RDEPEND=">=virtual/jre-1.5"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}

	cd "${S}"
	unzip -q ${MY_P}-sources.jar || die
}

java_prepare() {
	cp "${FILESDIR}"/${P}-build.xml build.xml || die

	sed -i 's/\(<mkdir dir="${maven.build.outputDir}"\/>\)/\1<javac srcdir="." destdir="${maven.build.outputDir}" \/>/g' build.xml || die
}

src_compile() {
	java-pkg-2_src_compile

	if use doc ; then
		javadoc -d javadoc $(find javax -name "*.java") || die "Javadoc failed"
	fi
}

src_install() {
	java-pkg_newjar target/javax.inject-${PV}.jar

	use doc && java-pkg_dojavadoc javadoc
	use source && java-pkg_dosrc javax
}
