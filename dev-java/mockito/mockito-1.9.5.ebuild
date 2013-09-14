# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/mockito/mockito-1.9.5.ebuild,v 1.1 2013/09/14 05:18:43 ercpe Exp $

EAPI="5"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="A mocking framework for Java"
HOMEPAGE="https://code.google.com/p/mockito/"
SRC_URI="https://${PN}.googlecode.com/files/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

CDEPEND="dev-java/junit:4
	dev-java/cglib:3
	dev-java/objenesis:0"
RDEPEND=">=virtual/jre-1.5
	${CDEPEND}"
DEPEND=">=virtual/jdk-1.5
	app-arch/unzip
	${CDEPEND}"

S="${WORKDIR}"

JAVA_GENTOO_CLASSPATH="junit-4,cglib-3,objenesis"

src_unpack() {
	unpack ${A}
	unzip "${S}"/sources/${PN}-core-${PV}-sources.jar -d src/ || die
}

java_prepare() {
	rm -rf "${S}"/src/org/mockito/{cglib,asm} || die
	find src/ -name "*.java" | xargs sed -i -e 's/import org.mockito.cglib/import net.sf.cglib/g' || die
}
