# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/json-simple/json-simple-1.0_pre20080420.ebuild,v 1.1 2011/09/25 09:21:35 serkan Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Simple Java toolkit for JSON"
HOMEPAGE="http://www.json.org"

MY_PN="${PN/-/_}"
# Bad usptream not having versioned releases
# orig SRC_URI="http://www.json.org/java/${MY_PN}.zip"
SRC_URI="mirror://gentoo/${MY_PN}-20080420.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

DEPEND=">=virtual/jdk-1.4
	app-arch/unzip"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/${MY_PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/extra-constructors-from-azureus.patch"
	rm -rv build lib || die
	cp -v "${FILESDIR}/build.xml" . || die
}

JAVA_ANT_ENCODING="ISO-8859-1"
EANT_BUILD_TARGET="dist"

src_install() {
	java-pkg_dojar dist/lib/*.jar
	dodoc README.txt || die

	use doc && java-pkg_dojavadoc javadoc
	use source && java-pkg_dosrc src/org
}
