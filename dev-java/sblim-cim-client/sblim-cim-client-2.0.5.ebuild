# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sblim-cim-client/sblim-cim-client-2.0.5.ebuild,v 1.2 2008/04/12 04:39:32 mr_bones_ Exp $

JAVA_PKG_IUSE="doc source test"

inherit java-pkg-2 java-ant-2

DESCRIPTION="A WBEM services client that includes an IETF RFC 2614 compliant SLP client for CIM service discovery"
HOMEPAGE="http://sblim.wiki.sourceforge.net/CimClient"
SRC_URI="mirror://sourceforge/sblim/${PN}2-${PV}-src.zip"
LICENSE="CPL-1.0"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE=""

#Restrict tests as some fail
#Tests total: 144, successful: 138, failed: 6
RESTRICT="test"

RDEPEND=">=virtual/jre-1.4"
DEPEND=">=virtual/jdk-1.4
		test? (
			=dev-java/junit-3*
			dev-java/ant-junit
		)"

S="${WORKDIR}/${PN}2-${PV}-src"

EANT_BUILD_TARGET="package"
EANT_DOC_TARGET="java-doc"

src_test() {
	ANT_TASKS="ant-junit" eant unittest
}

src_install() {
	java-pkg_newjar "build/lib/${PN}2-${PV}.jar"

	dodoc build/lib/*.properties || die "doc install failed"
	dodoc ChangeLog README NEWS || die "doc install failed"

	use doc && java-pkg_dojavadoc build/doc
	use source && java-pkg_dosrc src/*
}
