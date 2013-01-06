# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/tagsoup/tagsoup-1.1.ebuild,v 1.8 2011/12/31 12:47:53 sera Exp $

JAVA_PKG_IUSE="doc source"
WANT_ANT_TASKS="ant-trax"

inherit java-pkg-2 java-ant-2

DESCRIPTION="A SAX-compliant parser written in Java."

HOMEPAGE="http://mercury.ccil.org/~cowan/XML/tagsoup/"
SRC_URI="http://mercury.ccil.org/~cowan/XML/tagsoup/${P}-src.zip"
LICENSE="|| ( AFL-3.0 GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

# Needs the xslt task so full ant here
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip"
RDEPEND=">=virtual/jre-1.4"

EANT_BUILD_TARGET="dist"
EANT_DOC_TARGET="docs-api"

src_install() {
	java-pkg_newjar dist/lib/${P}.jar ${PN}.jar
	java-pkg_dolauncher ${PN} --jar ${PN}.jar

	doman ${PN}.1 || die
	dodoc CHANGES README TODO || die

	use doc && java-pkg_dojavadoc docs/api
	use source && java-pkg_dosrc src/{java,templates}/*
}
