# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/kunststoff/kunststoff-2.0.2-r1.ebuild,v 1.6 2007/10/24 05:37:14 wltjr Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Kunststoff Look&Feel"
SRC_URI="http://www.incors.org/archive/${P//./_}.zip"
HOMEPAGE="http://www.incors.org/archive"
LICENSE="LGPL-2.1"
SLOT="2.0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="doc source"
DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.4
	>=app-arch/unzip-5.50-r1"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd "${S}"

	rm -f *.jar
	cp "${FILESDIR}"/build.xml .
}

EANT_DOC_TARGET="docs"

src_install() {
	java-pkg_dojar dist/kunststoff.jar

	use doc && java-pkg_dojavadoc docs
	use source && java-pkg_dosrc src/com
}
