# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xt/xt-20051206-r3.ebuild,v 1.1 2015/03/16 18:12:40 ercpe Exp $

EAPI="4"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 eutils java-ant-2

DESCRIPTION="Java Implementation of XSL-Transformations"
SRC_URI="http://www.blnz.com/xt/${P}-src.zip"
HOMEPAGE="http://www.blnz.com/xt/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

COMMON_DEP="
	java-virtuals/servlet-api:2.4"
RDEPEND="
	>=virtual/jre-1.4
	dev-java/xp:0
	${COMMON_DEP}"
DEPEND="
	>=virtual/jdk-1.4
	app-arch/unzip
	${COMMON_DEP}"

java_prepare() {
	find "${WORKDIR}" -name '*.jar' -delete || die

	epatch "${FILESDIR}/20051206-java5.patch"
	epatch "${FILESDIR}/enum.patch"

	java-pkg_jar-from --into lib servlet-api-2.4
}

EANT_BUILD_TARGET="compile"
EANT_EXTRA_ARGS="-Dunzip.done=true"

src_install() {
	java-pkg_newjar lib/${PN}${PV}.jar
	java-pkg_dolauncher ${PN} \
		--main com.jclark.xsl.sax.Driver
	# loads this only on runtime
	java-pkg_register-dependency xp

	dodoc README.txt
	dohtml index.html

	use doc && java-pkg_dojavadoc docs/api
	use source && java-pkg_dosrc src/xt/java/com
}
