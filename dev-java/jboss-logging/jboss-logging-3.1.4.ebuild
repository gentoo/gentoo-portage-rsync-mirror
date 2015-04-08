# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jboss-logging/jboss-logging-3.1.4.ebuild,v 1.1 2014/05/10 12:34:44 tomwij Exp $

EAPI="5"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="JBoss logging framework"
HOMEPAGE="http://www.jboss.org/"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.GA.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

COMMON_DEPEND="dev-java/jboss-logmanager:0
	<dev-java/slf4j-api-1.7.7:0
	dev-java/log4j:0"

RDEPEND=">=virtual/jre-1.5
		${COMMON_DEPEND}"

DEPEND=">=virtual/jdk-1.5
		${COMMON_DEPEND}"

S="${WORKDIR}/${P}.GA/"

EANT_GENTOO_CLASSPATH="jboss-logmanager,slf4j-api,log4j"
JAVA_ANT_REWRITE_CLASSPATH="true"

java_prepare() {
	cp "${FILESDIR}"/${PN}-3.1.3-r1-build.xml build.xml || die
}

src_install() {
	java-pkg_newjar target/${PN}-3.1.3.GA.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/org
}
