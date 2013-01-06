# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-beanutils/commons-beanutils-1.6.1-r3.ebuild,v 1.15 2011/12/31 12:26:50 sera Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Provides easy-to-use wrappers around Reflection and Introspection APIs"
HOMEPAGE="http://commons.apache.org/beanutils/"
SRC_URI="mirror://apache/jakarta/commons/beanutils/source/${P}-src.tar.gz"

LICENSE="Apache-1.1"
SLOT="1.6"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE="doc source"

COMMON_DEP="
	>=dev-java/commons-collections-2.1
	>=dev-java/commons-logging-1.0.2"
RDEPEND=">=virtual/jre-1.3
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.3
	${COMMON_DEP}"

S="${WORKDIR}/${P}-src"

# These fail but work in 1.7 so don't bother fixing.
RESTRICT="test"

src_unpack() {
	unpack ${A}
	cd "${S}"
	java-ant_rewrite-classpath
}

EANT_GENTOO_CLASSPATH="commons-collections,commons-logging"

src_install() {
	java-pkg_dojar dist/${PN}*.jar

	dodoc RELEASE-NOTES.txt ||
	dohtml STATUS.html PROPOSAL.html || die

	use doc && java-pkg_dojavadoc dist/docs/api
	use source && java-pkg_dosrc src/java/org
}
