# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jsr67/jsr67-1.3.ebuild,v 1.5 2008/03/28 17:51:19 nixnut Exp $

JAVA_PKG_IUSE=""

inherit java-pkg-2

DESCRIPTION="SAAJ 1.3 (AKA JSR-67 MR3) API"
HOMEPAGE="https://saaj.dev.java.net/spec-1.3/"
SRC_URI="https://saaj.dev.java.net/spec-${PV}/saaj-api.jar"

LICENSE="sun-jsr67"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"

IUSE=""

RDEPEND=">=virtual/jre-1.4"
DEPEND=""

S="${WORKDIR}"

src_unpack() {
	:
}

src_install() {
	java-pkg_newjar "${DISTDIR}/saaj-api.jar"
}
