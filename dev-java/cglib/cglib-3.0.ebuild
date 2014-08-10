# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/cglib/cglib-3.0.ebuild,v 1.2 2014/08/10 20:09:21 slyfox Exp $

EAPI="5"

JAVA_PKG_IUSE="doc examples source test"

inherit java-pkg-2 java-ant-2

DESCRIPTION="cglib is a powerful, high performance and quality Code Generation Library"
HOMEPAGE="http://cglib.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-${PV}.jar"

LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS="~amd64 ~x86"

IUSE=""

COMMON_DEP="dev-java/asm:4
	>=dev-java/ant-core-1.7.0"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	test? ( dev-java/junit:4 )
	${COMMON_DEP}"

S="${WORKDIR}"

JAVA_ANT_REWRITE_CLASSPATH="yes"
EANT_GENTOO_CLASSPATH="asm-4 ant-core"

java_prepare() {
	find . -iname '*.jar' -delete || die
	epatch "${FILESDIR}"/${P}-build.xml.patch
}

src_install() {
	java-pkg_newjar dist/${P}.jar ${PN}.jar

	use doc && java-pkg_dojavadoc docs
	use source && java-pkg_dosrc src/proxy/net
	use examples && java-pkg_doexamples --subdir samples src/proxy/samples
}

src_test() {
	java-pkg-2_src_test
}
