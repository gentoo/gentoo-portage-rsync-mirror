# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/bctsp/bctsp-1.45.ebuild,v 1.1 2012/03/26 06:59:51 sera Exp $

EAPI=4

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

MY_P="${PN}-jdk15-${PV/./}"
DESCRIPTION="Java cryptography APIs"
HOMEPAGE="http://www.bouncycastle.org/java.html"
SRC_URI="http://www.bouncycastle.org/download/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

COMMON_DEPEND="
	~dev-java/bcprov-${PV}
	~dev-java/bcmail-${PV}"
RDEPEND="${COMMON_DEPEND}
	>=virtual/jre-1.5"
DEPEND="${COMMON_DEPEND}
	>=virtual/jdk-1.5
	app-arch/unzip"

S="${WORKDIR}"/${MY_P}

JAVA_GENTOO_CLASSPATH="bcprov,bcmail"

src_unpack() {
	default
	cd "${S}" || die
	unpack ./src.zip
	# Remove tests
	rm -R org/bouncycastle/tsp/test || die
}
