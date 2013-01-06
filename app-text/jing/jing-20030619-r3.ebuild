# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/jing/jing-20030619-r3.ebuild,v 1.4 2007/03/30 13:32:59 betelgeuse Exp $

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Jing: A RELAX NG validator in Java"
HOMEPAGE="http://thaiopensource.com/relaxng/jing.html"
SRC_URI="http://www.thaiopensource.com/download/${P}.zip"
LICENSE="BSD Apache-1.1"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="doc source"
COMMON_DEPEND="
	=dev-java/saxon-8*
	>=dev-java/xerces-2.7
	dev-java/iso-relax
	dev-java/xalan
	dev-java/relaxng-datatype
	dev-java/ant-core"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEPEND}"
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	source? ( app-arch/zip )
	${COMMON_DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	cp ${FILESDIR}/build-r1.xml build.xml || die

	mkdir src/
	cd src/
	unpack ./../src.zip
	# Has java.util.regex, xerces2 and xerces1 implementation
	# We only need the first one
	rm -vr com/thaiopensource/datatype/xsd/regex/{xerces,xerces2} || die
	epatch "${FILESDIR}/build-patch.diff"
	epatch "${FILESDIR}/${P}-xerces.patch"

	#remove bundled relaxng-datatype
	rm -r org || die

	cd ../bin/
	rm -v *.jar || die
	java-pkg_jar-from iso-relax
	java-pkg_jar-from xerces-2
	java-pkg_jar-from xalan
	java-pkg_jar-from saxon saxon8.jar saxon.jar
	java-pkg_jar-from relaxng-datatype
	java-pkg_jar-from ant-core
}

src_compile() {
	eant jar #premade javadocs
}

src_test() {
	local cp
	for jar in bin/*.jar; do
		cp="${cp}:${jar}"
	done
	# would need some test files could probably take this from the gcj version
	#java -cp ${cp} com.thaiopensource.datatype.xsd.regex.test.TestDriver || die
	#java -cp ${cp} com.thaiopensource.datatype.relaxng.util.TestDriver || die
	#java -cp ${cp} com.thaiopensource.datatype.xsd.regex.test.CategoryTest \
	#	|| die
}

src_install() {
	java-pkg_dojar bin/jing.jar
	java-pkg_dolauncher ${PN} --main com.thaiopensource.relaxng.util.Driver
	use doc && java-pkg_dohtml -r doc/* readme.html
	use source && java-pkg_dosrc src/com
}
