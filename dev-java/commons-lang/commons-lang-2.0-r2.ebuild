# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-lang/commons-lang-2.0-r2.ebuild,v 1.13 2011/12/19 12:18:25 sera Exp $

EAPI="2"
JAVA_PKG_IUSE="doc source test"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Jakarta components to manipulate core java classes"
HOMEPAGE="http://commons.apache.org/lang/"
SRC_URI="mirror://apache/jakarta/commons/lang/source/${P}-src.tar.gz"
DEPEND=">=virtual/jdk-1.4
	test? ( dev-java/ant-junit )"
RDEPEND=">=virtual/jre-1.4"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

S="${WORKDIR}/${P}-src"

java_prepare() {
	rm -v *.jar || die
}

src_install() {
	java-pkg_newjar dist/${P}.jar ${PN}.jar

	dodoc RELEASE-NOTES.txt || die
	java-pkg_dohtml DEVELOPERS-GUIDE.html PROPOSAL.html STATUS.html
	use doc && java-pkg_dojavadoc dist/docs/api
	use source && java-pkg_dosrc src/java/*
}
