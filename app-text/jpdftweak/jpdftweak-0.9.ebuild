# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/jpdftweak/jpdftweak-0.9.ebuild,v 1.2 2009/03/09 14:17:22 armin76 Exp $

EAPI=2

inherit java-pkg-2 java-ant-2

DESCRIPTION="Swiss Army Knife for PDF files"
HOMEPAGE="http://jpdftweak.sourceforge.net"
SRC_URI="mirror://sourceforge/jpdftweak/${PN}-src-${PV}.zip"
LICENSE="GPL-2"
SLOT="0"
RESTRICT=""
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND="dev-java/itext:0
	dev-java/jgoodies-forms:0"

RDEPEND=">=virtual/jre-1.5
	${COMMON_DEPEND}"

DEPEND=">=virtual/jdk-1.5
	app-arch/unzip
	${COMMON_DEPEND}"

S="${WORKDIR}"

src_prepare() {
	cd lib || die
	java-pkg_jar-from jgoodies-forms forms.jar
	java-pkg_jar-from itext iText.jar itext.jar
	java-pkg-2_src_prepare
}

src_install() {
	java-pkg_dojar "${PN}.jar"
	java-pkg_dolauncher ${PN} --main jpdftweak.Main
	dodoc "README.txt" || die "dodoc failed"
	dohtml manual/* || die "dohtml failed"
}
