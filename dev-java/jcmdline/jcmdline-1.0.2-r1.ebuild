# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jcmdline/jcmdline-1.0.2-r1.ebuild,v 1.5 2008/01/05 22:24:33 betelgeuse Exp $

JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Library for parsing/handling of command line parameters"
HOMEPAGE="http://jcmdline.sourceforge.net/"
SRC_URI="mirror://sourceforge/jcmdline/${P}.zip"
LICENSE="MPL-1.1"
SLOT="1.0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND=">=virtual/jdk-1.4
	app-arch/unzip"
RDEPEND=">=virtual/jre-1.4"

src_unpack() {
	unpack ${A}

	cd "${S}"
	rm -f *.jar

	epatch "${FILESDIR}/${P}-gentoo.patch"
}

EANT_DOC_TARGET="doc"

src_install() {
	java-pkg_dojar *.jar

	dodoc CHANGES CREDITS README
	use doc && java-pkg_dojavadoc doc/jcmdline/api
	use source && java-pkg_dosrc src/*
}
