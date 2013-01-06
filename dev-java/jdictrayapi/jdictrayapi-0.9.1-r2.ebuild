# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdictrayapi/jdictrayapi-0.9.1-r2.ebuild,v 1.5 2007/10/24 05:04:38 wltjr Exp $

JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

MY_PN="jdic"
MY_P=${MY_PN}-${PV}
DESCRIPTION="The JDesktop Integration Components (JDIC) tray icon API"
HOMEPAGE="https://jdic.dev.java.net/"
SRC_URI="https://jdic.dev.java.net/files/documents/880/16466/${MY_P}-src.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="examples"

DEPEND=">=virtual/jdk-1.4
		app-arch/unzip"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/${MY_P}-src/${MY_PN}"

#Patch takes care of it
JAVA_PKG_BSFIX="off"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/0.8.7-gentoo.patch"
	find -type d -name CVS -exec rm -r {} \; >/dev/null 2>&1
}

src_compile() {
	eant buildunixjar buildunixjni_tray $(use_doc docs)
}

src_install() {
	cd "${S}"/dist/linux
	java-pkg_dojar jdic.jar
	java-pkg_doso libtray.so
	use doc && java-pkg_dojavadoc "${S}"/../docs
	use source && java-pkg_dosrc "${S}"/src/share/classes/* "${S}"/src/unix/classes/*
	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -r "${S}"/demo/Tray/* "${D}"/usr/share/doc/${PF}/examples/
	fi
}
