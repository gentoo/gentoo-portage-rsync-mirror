# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jakarta-oro/jakarta-oro-2.0.8-r2.ebuild,v 1.14 2012/01/01 13:29:31 sera Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="A set of text-processing Java classes."
HOMEPAGE="http://jakarta.apache.org/oro/index.html"
SRC_URI="mirror://apache/jakarta/oro/source/${P}.tar.gz"

LICENSE="Apache-1.1"
SLOT="2.0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE="examples"

DEPEND=">=virtual/jdk-1.3"
RDEPEND=">=virtual/jre-1.3"

EANT_DOC_TARGET="javadocs"

src_install() {
	java-pkg_newjar ${PN}*.jar

	if use doc; then
		dodoc CHANGES COMPILE CONTRIBUTORS ISSUES README STYLE TODO
		java-pkg_dohtml *.html
		java-pkg_dohtml -r docs/
	fi
	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -r src/java/examples/* ${D}/usr/share/doc/${PF}/examples
	fi
	use source && java-pkg_dosrc src/java/org
}
