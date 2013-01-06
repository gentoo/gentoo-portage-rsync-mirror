# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sblim-cim-client/sblim-cim-client-1.3.5.ebuild,v 1.2 2008/04/12 02:02:03 ali_bush Exp $

JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="A WBEM services client that includes an IETF RFC 2614 compliant SLP client for CIM service discovery"
HOMEPAGE="http://sblim.wiki.sourceforge.net/CimClient"
SRC_URI="mirror://sourceforge/sblim/${P}-src.zip"
LICENSE="CPL-1.0"
SLOT="1"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.4"
DEPEND=">=virtual/jdk-1.4"

S="${WORKDIR}/cim-client"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-java-doc-without-clean.patch"
}

EANT_BUILD_TARGET="package"
EANT_DOC_TARGET="java-doc"

src_install() {
	java-pkg_newjar cim-client/sblimCIMClient.jar sblim-cim-client.jar
	java-pkg_newjar cim-client/sblimSLPClient.jar sblim-slp-client.jar

	dodoc cim.defaults || die "doc install failed"
	dodoc ChangeLog README NEWS || die "doc install failed"

	use doc && java-pkg_dojavadoc cim-client/doc
	use source && java-pkg_dosrc org
}
