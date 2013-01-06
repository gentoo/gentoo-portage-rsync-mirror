# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xsdlib/xsdlib-20050627-r1.ebuild,v 1.13 2012/11/27 19:28:19 sera Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

MY_P="${PN}.${PV}"
DESCRIPTION="The Sun Multi-Schema XML Validator is a Java tool to validate XML documents against several kinds of XML schemata."
HOMEPAGE="https://msv.dev.java.net/"
SRC_URI="mirror://gentoo/${MY_P}.zip"

LICENSE="BSD Apache-1.1"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"

RDEPEND=">=virtual/jre-1.3
	>=dev-java/xerces-2.7
	dev-java/relaxng-datatype"
DEPEND=">=virtual/jdk-1.3
	app-arch/unzip
	${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	cp -i "${FILESDIR}/build-${PVR}.xml" build.xml || die

	rm -v *.jar || die
	mkdir lib && cd lib
	java-pkg_jarfrom relaxng-datatype
	java-pkg_jarfrom xerces-2
}

src_compile() {
	local antflags="-Dproject.name=${PN} jar"
	eant ${antflags} $(use_doc)
}

src_install() {
	java-pkg_dojar dist/${PN}.jar

	dodoc README.txt || die
	dohtml HowToUse.html || die

	use doc && java-pkg_dojavadoc dist/doc/api
	use source && java-pkg_dosrc src/* src-apache/*
}
