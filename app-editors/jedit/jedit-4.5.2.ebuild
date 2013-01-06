# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/jedit/jedit-4.5.2.ebuild,v 1.2 2012/07/13 12:10:13 caster Exp $

EAPI=4

WANT_ANT_TASKS="ant-nodeps ant-apache-bsf ant-contrib"
JAVA_PKG_IUSE="doc"

inherit java-pkg-2 java-ant-2 eutils fdo-mime

DESCRIPTION="Programmer's editor written in Java"
HOMEPAGE="http://www.jedit.org"
SRC_URI="mirror://sourceforge/${PN}/${PN}${PV}source.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
SLOT="0"
IUSE=""

RDEPEND="
	>=virtual/jre-1.6"
# Fails to build docs with jdk7 #411371
DEPEND="
	>=virtual/jdk-1.6
	doc? (
		virtual/jdk:1.6
		=app-text/docbook-xml-dtd-4.3*
		>=app-text/docbook-xsl-stylesheets-1.65.1
		dev-libs/libxslt
	)
	dev-java/bsh[bsf]"

S="${WORKDIR}/jEdit"

JEDIT_HOME="/usr/share/${PN}"

java_prepare() {
	if use doc; then
		local xsl=$(echo /usr/share/sgml/docbook/xsl-stylesheets-*)
		xsl=${xsl// *}

		local xml=$(echo /usr/share/sgml/docbook/xml-dtd-4.3*)
		xml=${xml// *}

		echo "build.directory=." > build.properties
		echo "docbook.dtd.catalog=${xml}/docbook.cat" >> build.properties
		echo "docbook.xsl=${xsl}" >> build.properties
	fi

	# still need to do: bsh, com.microstar.xml.*, org.gjt.*
	java-pkg_filter-compiler jikes

	mkdir -p lib/{ant-contrib,default-plugins,scripting}
}

EANT_ANT_TASKS="${WANT_ANT_TASKS} bsh"
JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_EXTRA_ARGS="-Divy.jar.present=true -Divy.done=true"
EANT_BUILD_TARGET="build"
# TODO could build more docs, ie userdocs target instead of generate-javadoc
EANT_DOC_TARGET="generate-javadoc"
# in fact needed only for docs, but shouldn't hurt
EANT_NEEDS_TOOLS="true"

src_install () {
	dodir ${JEDIT_HOME}
	cp -R build/${PN}.jar jars doc macros modes properties startup \
		"${D}${JEDIT_HOME}" || die

	java-pkg_regjar ${JEDIT_HOME}/${PN}.jar

	java-pkg_dolauncher ${PN} --main org.gjt.sp.jedit.jEdit

	use doc && java-pkg_dojavadoc build/classes/javadoc/api

	make_desktop_entry ${PN} \
		jEdit \
		${JEDIT_HOME}/doc/${PN}.png \
		"Development;Utility;TextEditor"

	# keep the plugin directory
	keepdir ${JEDIT_HOME}/jars
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	elog "The system directory for jEdit plugins is"
	elog "${JEDIT_HOME}/jars"
	elog "If you get plugin related errors on startup, first try updating them."
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	elog "jEdit plugins installed into /usr/share/jedit/jars"
	elog "(after installation of jEdit itself) haven't been"
	elog "removed. To get rid of jEdit completely, you may"
	elog "want to run"
	elog ""
	elog "\trm -r ${JEDIT_HOME}"
	elog "Ignore this message if you are reinstalling or upgrading."
}
