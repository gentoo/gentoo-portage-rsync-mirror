# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jsr223/jsr223-1.0.ebuild,v 1.2 2008/12/20 22:01:26 maekke Exp $

JAVA_PKG_IUSE=""

inherit java-pkg-2

DESCRIPTION="Scripting for the Java(TM) Platform"
HOMEPAGE="http://jcp.org/en/jsr/detail?id=223"
SRC_URI="sjp-1_0-fr-ri.zip"

LICENSE="sun-bcla-jsr223"
RESTRICT="fetch"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND="app-arch/unzip"

S="${WORKDIR}"

pkg_nofetch() {

	einfo "Please go to:"
	einfo " http://jcp.org/aboutJava/communityprocess/final/jsr223/index.html"
	einfo "then click on Download button in Reference Implementation and Technology Compatibility Kit"
	einfo "section and download file:"
	einfo " ${SRC_URI}"
	einfo "and place it in:"
	einfo " ${DISTDIR}"

}

src_compile() {
	:
}

src_install() {
	java-pkg_dojar script-api.jar
}
