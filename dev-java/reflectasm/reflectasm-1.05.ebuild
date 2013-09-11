# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/reflectasm/reflectasm-1.05.ebuild,v 1.1 2013/09/11 17:37:01 ercpe Exp $

EAPI="5"

JAVA_PKG_IUSE="doc source test"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="High performance Java reflection"
HOMEPAGE="https://code.google.com/p/reflectasm/"
SRC_URI="https://${PN}.googlecode.com/files/${P}.zip"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="dev-java/asm:3"

DEPEND="${CDEPEND}
	test? ( dev-java/junit:4 )
	>=virtual/jdk-1.5"

RDEPEND="${CDEPEND}
	>=virtual/jre-1.5"

S="${WORKDIR}/${P}/java"

JAVA_GENTOO_CLASSPATH="asm-3"
JAVA_SRC_DIR="${S}/src"

src_prepare() {
	rm "${S}"/pom.xml || die
}

src_test() {
	mkdir target/tests || die
	testcp="$(java-pkg_getjars ${JAVA_GENTOO_CLASSPATH},junit-4):target/tests:${PN}.jar"
	ejavac -cp "${testcp}" -d target/tests $(find test/ -name "*.java")
	tests=$(find target/tests -name "*Test.class" \
			| sed -e 's/target\/tests\///g' -e "s/\.class//" -e "s/\//./g" \
			| grep -vP '\$');
	ejunit4 -cp "${testcp}" ${tests}
}
