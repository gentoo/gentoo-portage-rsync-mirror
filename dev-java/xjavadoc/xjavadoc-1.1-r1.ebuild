# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xjavadoc/xjavadoc-1.1-r1.ebuild,v 1.7 2007/08/03 15:46:13 betelgeuse Exp $

JAVA_PKG_IUSE="source"
WANT_ANT_TASKS="ant-nodeps"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="A standalone implementation of JavaDoc engine suited for XDoclet"
HOMEPAGE="http://xdoclet.sourceforge.net/xjavadoc/"
SRC_URI="mirror://sourceforge/xdoclet/${P}-src.tar.gz
	mirror://gentoo/${P}-supplement.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

COMMON_DEPEND="dev-java/commons-collections
	=dev-java/junit-3*"

RDEPEND=">=virtual/jre-1.4
	${COMMON_DEPEND}"
DEPEND=">=virtual/jdk-1.4
	dev-java/javacc
	${COMMON_DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# remove the junit tests, would need xdoclet, causing circular dep
	epatch ${FILESDIR}/${P}-nojunit.patch

	cd "${S}/lib"
	rm -v *.jar || die
	java-pkg_jar-from commons-collections,junit
	java-pkg_jar-from --build-only javacc
}

src_install() {
	java-pkg_dojar target/${PN}.jar
	use source && java-pkg_dosrc src/*
}
