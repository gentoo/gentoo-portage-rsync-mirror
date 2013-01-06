# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/tapestry/tapestry-3.0.4.ebuild,v 1.3 2008/10/21 20:48:35 betelgeuse Exp $

EAPI=1
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Tapestry is an open-source framework for creating dynamic, robust, highly scalable web applications in Java."
SRC_URI="mirror://apache/${PN}/Tapestry-${PV}-src.zip"

HOMEPAGE="http://tapestry.apache.org/"
LICENSE="Apache-2.0"
SLOT="3.0"
KEYWORDS="~x86 ~amd64"

COMMON_DEP="
	dev-java/servletapi:2.4
	dev-java/commons-lang:2.1
	dev-java/commons-logging:0
	dev-java/commons-codec:0
	dev-java/commons-digester:0
	dev-java/commons-fileupload:0
	dev-java/commons-beanutils:1.7
	dev-java/bsf:2.3
	dev-java/jakarta-oro:2.0
	dev-java/javassist:2
	dev-java/ognl:2.6"

RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"

DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	${COMMON_DEP}"

IUSE=""

S="${WORKDIR}/Tapestry-${PV}"

src_unpack() {
	unpack ${A}

	cd "${S}/"
	mkdir config

	cp "${FILESDIR}/Version.properties" config/
	cp "${FILESDIR}/build.properties" config/
	cp "${FILESDIR}/common.properties" config/

	cd "${S}/framework"
	java-ant_rewrite-classpath
}

src_compile() {
	mkdir lib

	cd framework

	gentoo_classpath="$(java-pkg_getjars commons-logging,commons-fileupload,commons-lang-2.1,commons-codec,commons-beanutils-1.7,commons-digester)"
	gentoo_classpath="$gentoo_classpath:$(java-pkg_getjars servletapi-2.4,ognl-2.6,bsf-2.3,jakarta-oro-2.0,javassist-2)"

	eant -Dgentoo.classpath="$gentoo_classpath"

	use doc && javadoc -sourcepath src/ org.apache.tapestry -d ../javadoc
}

src_install() {
	java-pkg_newjar "lib/${P}.jar"

	use source && java-pkg_dosrc framework/src/org
	use doc && java-pkg_dojavadoc javadoc
}
