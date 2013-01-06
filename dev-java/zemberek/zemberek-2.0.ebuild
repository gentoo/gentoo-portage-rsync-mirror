# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/zemberek/zemberek-2.0.ebuild,v 1.5 2007/11/25 12:30:14 drac Exp $

JAVA_PKG_IUSE="source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Zemberek NLP library"
HOMEPAGE="http://code.google.com/p/zemberek/"
SRC_URI="http://${PN}.googlecode.com/files/${P}-src.zip"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="amd64 x86"
LANGS="tr tk"
IUSE="doc"

S=${WORKDIR}/${P}-src

for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X/-/_}"
done

RDEPEND=">=virtual/jre-1.5"

DEPEND=">=virtual/jdk-1.5
	app-arch/unzip"

src_unpack() {
	unpack ${A}
	cd "${S}"
	mkdir lib/dagitim
	rm lib/gelistirme/*.jar
}

src_compile() {
	strip-linguas ${LANGS}
	local anttargs
	for jar in cekirdek demo ${LINGUAS}; do
		anttargs="${anttargs} jar-${jar/tk/tm}"
	done
	eant ${anttargs} $(use_doc javadocs)
}

src_install() {
	strip-linguas ${LANGS}
	local sourcetrees=""
	for jar in cekirdek demo ${LINGUAS}; do
		java-pkg_newjar dagitim/jar/zemberek-${jar/tk/tm}-${PV}.jar zemberek2-${jar/tk/tm}.jar
		sourcetrees="${sourcetrees} src/${jar/tk/tm}/*"
	done
	use source && java-pkg_dosrc ${sourcetrees}
	use doc && java-pkg_dojavadoc build/java-docs/api
	java-pkg_dolauncher zemberek-demo --main net.zemberek.demo.DemoMain
	dodoc dokuman/lisanslar/* || die
	dodoc surumler.txt || die
}
