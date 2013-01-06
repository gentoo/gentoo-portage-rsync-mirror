# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/findbugs/findbugs-1.3.9.ebuild,v 1.1 2011/04/11 01:26:55 nerdboy Exp $

EAPI=3

WANT_ANT_TASKS="ant-nodeps ant-junit"
JAVA_PKG_IUSE="doc source test"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Find Bugs in Java Programs"
HOMEPAGE="http://findbugs.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-source.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="dev-java/ant-core
	dev-java/commons-lang:2.1
	dev-java/apple-java-extensions-bin:0
	>=dev-java/asm-3.1:3
	dev-java/dom4j
	dev-java/bcel[findbugs]
	dev-java/jsr305
	dev-java/jformatstring
	=dev-java/jaxen-1.1*
	=dev-java/jdepend-2.9*
	doc? (
		=dev-java/saxon-6.5*
		app-text/docbook-xsl-stylesheets
	)
	dev-java/ant-junit
	=dev-java/junit-4*
"
RDEPEND=">=virtual/jre-1.5
	dev-java/icu4j:0
	${CDEPEND}"

DEPEND=">=virtual/jdk-1.5
	app-arch/unzip
	${CDEPEND}"

JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_DOC_TARGET="apiJavadoc"
EANT_BUILD_TARGET="rebuild"
EANT_GENTOO_CLASSPATH="ant-core,jdepend"
EANT_ANT_TASKS="ant-nodeps,junit"
ANT_OPTS="-Xmx256m"

pkg_setup() {
	use doc && ewarn "Installing javadocs does not pass sanity check."

	java-pkg-2_pkg_setup
}

java_prepare() {
	find -name "*.jar" | xargs rm -v
	sed -i -e "s|this directory|the plugin directory|" \
		"${S}"/plugin/README

	cd "${S}"/lib
	java-pkg_jar-from ant-core ant.jar
	java-pkg_jar-from bcel bcel.jar bcel.jar
	java-pkg_jar-from apple-java-extensions-bin
	java-pkg_jar-from asm-3 asm.jar asm-3.1.jar
	java-pkg_jar-from asm-3 asm-analysis.jar asm-analysis-3.1.jar
	java-pkg_jar-from asm-3 asm-commons.jar asm-commons-3.1.jar
	java-pkg_jar-from asm-3 asm-tree.jar asm-tree-3.1.jar
	java-pkg_jar-from asm-3 asm-util.jar asm-util-3.1.jar
	java-pkg_jar-from asm-3 asm-xml.jar asm-xml-3.1.jar
	java-pkg_jar-from commons-lang-2.1 commons-lang.jar commons-lang-2.4.jar
	java-pkg_jar-from dom4j-1 dom4j.jar dom4j-1.6.1.jar
	java-pkg_jar-from jsr305
	java-pkg_jar-from jformatstring
	java-pkg_jar-from --with-dependencies jdepend
	java-pkg_jar-from jaxen-1.1

	use doc && java-pkg_jar-from saxon-6.5

	# yes, this needed for the build
	java-pkg_jar-from junit-4
	java-pkg_jar-from ant-junit
}

src_test() {
	ANT_TASKS="ant-nodeps ant-junit junit" eant runjunit
}

src_install() {
	java-pkg_dojar "${S}"/lib/${PN}*.jar
	java-pkg_dojar "${S}"/lib/annotations.jar "${S}"/lib/findbugs-ant.jar
	# no plugins installed yet (see README.plugins)
	dodir /usr/share/${PN}/plugin
	newdoc "${S}"/plugin/README README.plugin
	# "${S}"/plugin/*.jar
	# dosym /usr/share/${PN}/lib/coreplugin.jar  /usr/share/${PN}/plugin/
	dobin "${FILESDIR}"/findbugs

	use doc && java-pkg_dojavadoc "${S}"/apiJavaDoc
	use source && java-pkg_dosrc "${S}"/src
}

pkg_postinst() {
	elog
	elog "Scanning large class files can take large amounts of memory, so"
	elog "if you experiance out of memory errors, edit /usr/bin/findbugs"
	elog "and increase the VM memory allocation (or buy more RAM ;)"
	elog
}
