# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/aspectj/aspectj-1.7.3.ebuild,v 1.1 2013/09/14 05:07:04 ercpe Exp $

EAPI="5"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="A seamless aspect-oriented extension to the Java programming language"
HOMEPAGE="http://eclipse.org/aspectj/"
SRC_URI="http://www.eclipse.org/downloads/download.php?file=/tools/aspectj/aspectj-1.7.3-src.jar&r=1 -> ${P}.jar"

LICENSE="EPL-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

CDEPEND="dev-java/asm:4
	dev-java/commons-logging:0"

DEPEND=">=virtual/jdk-1.5
	app-arch/zip
	${CDEPEND}"
RDEPEND=">=virtual/jre-1.5
	${CDEPEND}"

S="${WORKDIR}"

JAVA_SRC_DIR="${S}/src"
JAVA_GENTOO_CLASSPATH="commons-logging,asm-4"

src_unpack() {
	default
	unzip "${S}/aspectjweaver1.7.3-src.jar" -d "${S}/src/" || die
}

src_prepare() {
	default
	# needs part of BEA JRockit to compile
	rm "${S}"/src/org/aspectj/weaver/loadtime/JRockitAgent.java || die
	# aspectj uses a renamed version of asm:4
	find -name "*.java" -exec sed -i -e 's/import aj.org.objectweb.asm./import org.objectweb.asm./g' {} \; || die
}
