# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xstream/xstream-1.3.1-r2.ebuild,v 1.3 2015/06/13 11:37:40 ago Exp $

EAPI=5

JAVA_PKG_IUSE="doc source test"

inherit java-pkg-2 java-ant-2

DESCRIPTION="A text-processing Java classes that serialize objects to XML and back again"
HOMEPAGE="http://xstream.codehaus.org/index.html"
SRC_URI="http://repository.codehaus.org/com/thoughtworks/${PN}/${PN}-distribution/${PV}/${PN}-distribution-${PV}-src.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"

IUSE=""

CDEPEND="
	dev-java/cglib:3
	dev-java/dom4j:1
	dev-java/jdom:1.0
	dev-java/joda-time:0
	dev-java/xom:0
	dev-java/xpp3:0
	dev-java/xml-commons-external:1.3
	dev-java/jettison:0
	java-virtuals/stax-api
	"

DEPEND="
	>=virtual/jdk-1.6
	app-arch/unzip
	test? (
		dev-java/ant-junit
		dev-java/ant-trax
		dev-java/junit:0
		dev-java/xml-writer:0
		dev-java/commons-lang:2.1
		dev-java/jmock:1.0
		dev-java/jakarta-oro:2.0
		dev-java/stax:0
		dev-java/wstx:3.2
	)
	${CDEPEND}"
RDEPEND="
	>=virtual/jre-1.6
	${CDEPEND}"

S="${WORKDIR}/${P}/${PN}"

JAVA_ANT_REWRITE_CLASSPATH="true"

src_unpack() {
	unpack ${A}
	cd "${S}/lib"
	rm -v *.jar || die
	rm -rf jdk1.3 || die
}

EANT_GENTOO_CLASSPATH="xpp3,jdom-1.0,xom,dom4j-1,joda-time,cglib-3
xml-commons-external-1.3,jettison,stax-api"

EANT_BUILD_TARGET="benchmark:compile jar"
EANT_EXTRA_ARGS="-Dversion=${PV}"

src_test(){
	EANT_GENTOO_CLASSPATH="${EANT_GENTOO_CLASSPATH}
		junit,jmock-1.0,commons-lang-2.1,xml-writer,wstx-3.2,stax,jakarta-oro-2.0" \
		ANT_TASKS="ant-junit ant-trax" eant test || die "Tests failed"
}

src_install(){
	java-pkg_newjar target/${P}.jar
	java-pkg_newjar target/${PN}-benchmark-${PV}.jar ${PN}-benchmark.jar

	use doc && java-pkg_dojavadoc target/javadoc
	use source && java-pkg_dosrc src/java/com
}

pkg_postinst(){
	elog "Major Changes from 1.2 See:"
	elog "http://xstream.codehaus.org/changes.html"
	elog "to prevent breakage ..."
}
