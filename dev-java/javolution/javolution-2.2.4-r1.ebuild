# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/javolution/javolution-2.2.4-r1.ebuild,v 1.3 2007/06/19 06:32:23 opfer Exp $

JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Java Solution for Real-Time and Embedded Systems"
SRC_URI="http://javolution.org/${P}-src.zip"
HOMEPAGE="http://javolution.org"
LICENSE="LGPL-2.1"
SLOT="2.2.4"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=virtual/jdk-1.4
	app-arch/unzip"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/javolution-${PV%.*}"

EANT_BUILD_TARGET="init_1.4 compile jar"
EANT_DOC_TARGET="doc"

src_unpack() {
	unpack ${A}
	java-pkg_filter-compiler jikes
}

src_install() {

	java-pkg_dojar javolution.jar

	dodoc doc/coding_standard.txt
	use doc && java-pkg_dojavadoc api
	use source && java-pkg_dosrc "${S}/src/javolution"

}
