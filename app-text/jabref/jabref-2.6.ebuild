# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/jabref/jabref-2.6.ebuild,v 1.5 2013/02/02 01:23:15 calchan Exp $

EAPI=2

JAVA_PKG_IUSE="doc"
inherit eutils java-pkg-2 java-ant-2

MY_PV="${PV/_beta/b}"

DESCRIPTION="GUI frontend for BibTeX, written in Java"
HOMEPAGE="http://jabref.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/JabRef-${MY_PV}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="mysql"

CDEPEND="dev-java/spin:0
	|| ( >=dev-java/glazedlists-1.7.0-r1:0 >=dev-java/glazedlists-1.7.0:0[java5] )
	>=dev-java/antlr-2.7.3:0[java]
	>=dev-java/jgoodies-forms-1.1.0:0
	dev-java/jgoodies-looks:2.0
	>=dev-java/microba-0.4.3:0
	dev-java/jempbox:0
	dev-java/pdfbox:0
	dev-java/commons-logging:0
	dev-java/jpf:1.5
	dev-java/jpfcodegen:0
	mysql? ( dev-java/jdbc-mysql:0 )"

RDEPEND="virtual/jre:1.6
	${CDEPEND}"

DEPEND="virtual/jdk:1.6
	${CDEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"

java_prepare() {
	# moves jarbundler definition to where it's needed (not by us)
	# don't call unjarlib, don't want to absorb deps
	# failonerror in jpfcodegen
	epatch "${FILESDIR}/${PN}-2.4-build.xml.patch"

	# bug #268252
	java-ant_xml-rewrite -f build.xml -d -e javac -a encoding -v UTF-8

	mkdir libs || die
	mv lib/antlr-3.0b5.jar libs/ || die

	rm -v lib/*.jar lib/plugin/*.jar \
		src/java/net/sf/jabref/plugin/core/generated/*.java || die
}

JAVA_ANT_REWRITE_CLASSPATH="true"

src_compile() {
	java-pkg_filter-compiler jikes

	local gcp=$(java-pkg_getjars --with-dependencies antlr,spin,glazedlists,jgoodies-looks-2.0,jgoodies-forms,microba,jempbox,pdfbox,commons-logging,jpf-1.5,jpfcodegen)
	gcp="${gcp}:libs/antlr-3.0b5.jar"
	eant -Dgentoo.classpath="${gcp}" jars \
		$(use_doc -Dbuild.javadocs=build/docs/api javadocs)
}

src_install() {
	java-pkg_newjar build/lib/JabRef-${MY_PV}.jar
	java-pkg_dojar libs/antlr-3.0b5.jar

	use doc && java-pkg_dojavadoc build/docs/api
	dodoc src/txt/README

	java-pkg_dolauncher ${PN} \
		--main net.sf.jabref.JabRef

	dodir /usr/share/${PN}/lib/plugins
	keepdir /usr/share/${PN}/lib/plugins

	java-pkg_register-optional-dependency jdbc-mysql

	newicon src/images/JabRef-icon-48.png JabRef-icon.png || die
	make_desktop_entry ${PN} JabRef JabRef-icon Office
	echo "MimeType=text/x-bibtex" >> "${D}/usr/share/applications/${PN}-${PN}.desktop"
}

pkg_postinst() {
	elog "Users need to set their user java vm to one of the 1.6 slot for the search"
	elog "feature to work."
}
