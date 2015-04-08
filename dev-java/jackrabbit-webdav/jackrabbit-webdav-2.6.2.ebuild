# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jackrabbit-webdav/jackrabbit-webdav-2.6.2.ebuild,v 1.3 2015/04/02 18:10:58 mr_bones_ Exp $

EAPI="5"

JAVA_PKG_IUSE="doc test"

inherit java-pkg-2 java-ant-2

MY_PN="${PN/-*/}"

DESCRIPTION="Fully conforming implementation of the JRC API (specified in JSR 170 and 283)"
HOMEPAGE="http://jackrabbit.apache.org/"
SRC_URI="mirror://apache/${MY_PN}/${PV}/${MY_PN}-${PV}-src.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/${MY_PN}-${PV}/${PN}"

CDEPEND="dev-java/bndlib:0
	dev-java/commons-httpclient:3
	dev-java/slf4j-api:0
	java-virtuals/servlet-api:2.3"

DEPEND=">=virtual/jdk-1.5
	${CDEPEND}
	test? ( dev-java/junit:0 )"

RDEPEND=">=virtual/jre-1.5
	${CDEPEND}"

JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_GENTOO_CLASSPATH="bndlib,commons-httpclient-3,servlet-api-2.3,slf4j-api"
EANT_TEST_GENTOO_CLASSPATH="junit"

java_prepare() {
	cp "${FILESDIR}"/${P}-build.xml build.xml || die
}

src_test() {
	java-pkg-2_src_test
}

src_install() {
	java-pkg_newjar target/${P}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
}
