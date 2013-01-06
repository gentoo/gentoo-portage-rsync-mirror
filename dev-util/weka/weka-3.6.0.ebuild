# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/weka/weka-3.6.0.ebuild,v 1.2 2010/04/26 13:11:14 phajdan.jr Exp $

EAPI="2"

JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2 versionator

MY_P="${PN}-$(replace_all_version_separators '-')"
DESCRIPTION="A Java data mining package"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip"
HOMEPAGE="http://www.cs.waikato.ac.nz/ml/weka/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc x86"
DEPEND=">=virtual/jdk-1.5
	app-arch/unzip"
RDEPEND=">=virtual/jre-1.5"
IUSE=""

S="${WORKDIR}/${MY_P}"

EANT_BUILD_TARGET="exejar"
EANT_DOC_TARGET="docs"
JAVA_ANT_IGNORE_SYSTEM_CLASSES="true"

weka_get_max_memory() {
	if use amd64; then
		echo 512m
	else
		echo 256m
	fi
}

EANT_EXTRA_ARGS="-Djavac_max_memory=$(weka_get_max_memory)"

src_prepare() {
	unzip -qq "${PN}-src.jar" -d . || die "Failed to unpack the source"
	rm -v *.jar || die
	rm -rf doc || die
	mkdir lib || die
	epatch "${FILESDIR}"/${P}-build.xml.patch
	java-pkg-2_src_prepare
}

src_install() {
	java-pkg_dojar dist/${PN}.jar
	java-pkg_dolauncher weka --main "${PN}.gui.GUIChooser"

	# Really need a virtual to list all available drivers and pull the ones
	# instaled
	java-pkg_register-optional-dependency hsqldb,jdbc-mysql,mckoi-1

	use source && java-pkg_dosrc src/main/java/weka/

	dodoc README || die
	if use doc; then
		java-pkg_dojavadoc doc/
		insinto /usr/share/doc/${PF}
		doins WekaManual.pdf || die
	fi

	dodir /usr/share/${PN}/data/
	insinto /usr/share/${PN}/data/
	doins data/*
}
