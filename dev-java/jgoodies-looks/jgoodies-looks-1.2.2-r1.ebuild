# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jgoodies-looks/jgoodies-looks-1.2.2-r1.ebuild,v 1.6 2010/04/21 20:24:59 caster Exp $

inherit java-pkg-2 java-ant-2

MY_PN="looks"
MY_PV="${PV//./_}"
DESCRIPTION="JGoodies Looks Library"
HOMEPAGE="http://www.jgoodies.com/"
SRC_URI="http://www.jgoodies.com/download/libraries/${MY_PN}-${MY_PV}.zip"

LICENSE="BSD"
SLOT="1.2"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE="doc"

DEPEND=">=virtual/jdk-1.4.2
	dev-java/ant-core
	app-arch/unzip"
RDEPEND=">=virtual/jre-1.4.2"

S="${WORKDIR}/${MY_PN}-${PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	rm *.jar
	unzip ${MY_PN}-${PV}-src.zip &> /dev/null || die "Unpack Failed"
	cp "${FILESDIR}/build.xml" "${FILESDIR}/plastic.txt" .
}

src_compile() {
	eant jar $(use_doc)
}

src_install() {
	java-pkg_dojar ${MY_PN}.jar

	dodoc RELEASE-NOTES.txt
	use doc && java-pkg_dohtml -r build/doc
}
