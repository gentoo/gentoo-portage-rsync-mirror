# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/fastinfoset/fastinfoset-1.2.1.ebuild,v 1.5 2007/08/19 19:40:36 wltjr Exp $

JAVA_PKG_IUSE="source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Fast Infoset"
HOMEPAGE="https://fi.dev.java.net/"
SRC_URI="https://fi.dev.java.net/files/documents/2634/45735/FastInfoset_src_${PV}.zip"

LICENSE="CDDL"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~x86-fbsd"
IUSE=""

COMMON_DEP="dev-java/jsr173"

RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"

DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}
	app-arch/unzip"

S="${WORKDIR}"

src_unpack() {

	unpack ${A}

	mkdir src lib
	mv com org src/ || die

	cp "${FILESDIR}/build.xml-${PV}" "${S}/build.xml" || die

	cd "${S}/lib"
	java-pkg_jar-from jsr173

}

src_install() {

	java-pkg_newjar fi.jar

	use source && java-pkg_dosrc src/*

}
